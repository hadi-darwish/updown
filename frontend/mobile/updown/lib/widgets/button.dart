import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).cardColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
    //   child: ElevatedButton(
    //     onPressed: () {},
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: Theme.of(context).secondaryHeaderColor,
    //       padding: const EdgeInsets.symmetric(vertical: 15),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(5),
    //       ),
    //     ),
    //     child: const Text('Login'),
    //   ),
    // );
  }
}
