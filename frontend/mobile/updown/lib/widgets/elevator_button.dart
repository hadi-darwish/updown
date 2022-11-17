import 'package:flutter/material.dart';

class ElevatorButton extends StatelessWidget {
  const ElevatorButton({super.key, required this.floorNumber});
  final int floorNumber;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(70, 50)),
        maximumSize: MaterialStateProperty.all<Size>(Size(70, 50)),
      ),
      child: Text(
        floorNumber == 0 ? 'GF' : '$floorNumber',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
