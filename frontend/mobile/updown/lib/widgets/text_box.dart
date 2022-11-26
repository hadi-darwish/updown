import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox(
      {super.key,
      required this.text1,
      required this.text2,
      required this.theme});
  final String text1;
  final String text2;
  final String theme;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          color: theme == 'primary'
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        width: screenWidth * 0.90,
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: TextStyle(
                color: theme == 'primary'
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                color: theme == 'primary'
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ));
  }
}
