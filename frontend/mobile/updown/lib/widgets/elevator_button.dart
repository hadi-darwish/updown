import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: () async {
        if (!widget.disabled) {
          setState(() {
            isPressed = !isPressed;
          });
          await Travel().requestTravel(widget.floorNumber, widget.currentFloor);
          Future delayed = Future.delayed(const Duration(seconds: 1), () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Travel Request'),
                  content: const Text('Your travel request has been sent'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
            : MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
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
