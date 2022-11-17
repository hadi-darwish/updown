import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        width: 340,
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
              'Current Floor',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
            Text(
              '  1',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ));
  }
}
