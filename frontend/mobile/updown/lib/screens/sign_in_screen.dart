import 'package:flutter/material.dart';
import 'package:updown/providers/auth_provider.dart';
import 'package:updown/validators/email_validator.dart';
import 'package:updown/validators/password_validator.dart';
import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/input.dart';
import 'package:updown/widgets/top_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final textController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: TopBar(screenHeight: screenHeight),
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
                text: 'Sign In',
                type: 'primary',
                onPressed: () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (EmailValidator.validate(textController.text) == null &&
                      PasswordValidator.validate(passwordController.text) ==
                          null) {
                    if (await Auth().signIn(
                            textController.text, passwordController.text) ==
                        200) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }

                  print(textController.text);
                  print(passwordController.text);
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.2,
            ),
            SizedBox(
              child: Button(
                text: 'Guest Mode',
                type: 'secondary',
                onPressed: () {
                  Navigator.pushNamed(context, '/guestModeLogin');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
