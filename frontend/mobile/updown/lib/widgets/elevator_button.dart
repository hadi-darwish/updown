import 'package:flutter/material.dart';

class ElevatorButton extends StatefulWidget {
  const ElevatorButton({super.key, required this.floorNumber});
  final int floorNumber;

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
      onPressed: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
                width: 7.5,
                color: isPressed
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
