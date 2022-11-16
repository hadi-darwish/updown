import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:updown/validators/email_validator.dart';
import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/input.dart';
import 'package:updown/widgets/top_bar.dart';

class GuestModeLogin extends StatefulWidget {
  const GuestModeLogin({super.key});

  @override
  State<GuestModeLogin> createState() => _GuestModeLoginState();
}

class _GuestModeLoginState extends State<GuestModeLogin> {
  final textController = TextEditingController();
  final hostController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: TopBar(
        screenHeight: screenHeight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              child: LabeledInput(
                type: 'Email',
                placeholder: 'Email',
                textController: textController,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            SizedBox(
              child: LabeledInput(
                type: 'text',
                placeholder: 'Host ID',
                textController: hostController,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            SizedBox(
              child: LabeledInput(
                type: 'Password',
                placeholder: 'Password',
                textController: passwordController,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              child: Button(
                text: 'Enter',
                type: 'primary',
                onPressed: () {
                  print(textController.text);
                  print(hostController.text);
                  print(passwordController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
