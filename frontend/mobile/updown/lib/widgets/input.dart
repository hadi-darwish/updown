import 'package:flutter/material.dart';
import 'package:updown/validators/email_validator.dart';
import 'package:updown/validators/password_validator.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({
    super.key,
    required this.placeholder,
    required this.type,
    required this.textController,
  });
  final String placeholder;
  final String type;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    String? message;
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
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  message = 'Please enter a $placeholder';
                } else if (type == 'Email') {
                  message = EmailValidator.validate(value);
                } else if (type == 'Password') {
                  message = PasswordValidator.validate(value);
                }
                return message;
              },

              controller: textController,
              cursorWidth: 3,
              cursorRadius: const Radius.circular(5),
              decoration: InputDecoration(
                errorText: message != '' ? message : null,
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
              // onChanged: (message) => setState(() => message),
            ),
          ),
        ],
      ),
    );
  }
}
