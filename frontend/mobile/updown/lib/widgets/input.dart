import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput(
      {super.key,
      required this.placeholder,
      required this.type,
      required this.textController});
  final String placeholder;
  final String type;
  final TextEditingController textController;

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
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: textController,
              cursorWidth: 3,
              cursorRadius: const Radius.circular(5),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(197, 197, 197, 1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(197, 197, 197, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Enter $placeholder',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
              keyboardType: type == 'Email'
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              obscureText: type == 'Password' ? true : false,
              toolbarOptions: type == 'Password'
                  ? const ToolbarOptions(
                      copy: false,
                      cut: false,
                      paste: false,
                      selectAll: false,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
