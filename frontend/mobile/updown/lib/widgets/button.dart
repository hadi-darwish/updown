import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.type});
  final String text;
  final Function onPressed;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(43),
          backgroundColor: type == 'primary'
              ? Theme.of(context).primaryColor
              : type == 'third'
                  ? Theme.of(context).secondaryHeaderColor
                  : Colors.white,
          foregroundColor:
              type == 'primary' ? Colors.white : Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: type == 'secondary'
                ? BorderSide(color: Theme.of(context).primaryColor, width: 3)
                : BorderSide.none,
          ),
        ),
        child: Text(
          textAlign: TextAlign.center,
          text.toUpperCase(),
          style: TextStyle(
            color: type == 'primary'
                ? Colors.white
                : Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
