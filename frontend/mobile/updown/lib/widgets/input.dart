import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput(
      {super.key, required this.placeholder, required this.type});
  final String placeholder;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              placeholder,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              keyboardType: type == 'Email'
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              obscureText: type == 'Password' ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
