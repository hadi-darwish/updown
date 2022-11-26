import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:updown/providers/building_provider.dart';
import 'package:updown/providers/travel_provider.dart';

class ElevatorButton extends StatefulWidget {
  const ElevatorButton(
      {super.key,
      required this.floorNumber,
      required this.currentFloor,
      required this.disabled});
  final int floorNumber;
  final int currentFloor;
  final bool disabled;

  @override
  State<ElevatorButton> createState() => _ElevatorButtonState();
}

class _ElevatorButtonState extends State<ElevatorButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    var isOn = Provider.of<Travel>(context);
    var status = Provider.of<Building>(context);
    print('$isOn');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: () async {
        if (!widget.disabled) {
          setState(() {
            isPressed = !isPressed;
          });
          if (status.isOn == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Elevator is OFF'),
              ),
            );
            setState(() {
              isPressed = !isPressed;
            });
            return;
          }

          await Travel().requestTravel(widget.floorNumber, widget.currentFloor);
          Future delayed = Future.delayed(const Duration(seconds: 1), () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Travel Request'),
                  content: const Text('Your travel request has been sent'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        isOn.AnimationFrom(
                            widget.floorNumber, widget.currentFloor, context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            setState(() {
              isPressed = !isPressed;
            });
          });
        } else {
          null;
        }
      },
      style: ButtonStyle(
        overlayColor: !widget.disabled
            ? null
            : MaterialStateProperty.all<Color>(Colors.red.withOpacity(1)),
        backgroundColor: widget.disabled
            ? MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor.withOpacity(0.5))
            : isOn.onFloor == widget.floorNumber
                ? MaterialStateProperty.all<Color>(
                    Theme.of(context).secondaryHeaderColor)
                : MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
                width: 7.5,
                color: widget.disabled
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : isPressed
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).primaryColor),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(70, 50)),
        maximumSize: MaterialStateProperty.all<Size>(Size(70, 50)),
      ),
      child: Text(
        widget.floorNumber == 0 ? 'GF' : '${widget.floorNumber}',
        style: TextStyle(
          color: isPressed == true
              ? Theme.of(context).secondaryHeaderColor
              : Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
