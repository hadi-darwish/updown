import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/input.dart';
import 'package:updown/widgets/top_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Nunito',
        cardColor: const Color.fromRGBO(89, 219, 174, 1),
        primaryColor: const Color.fromRGBO(0, 48, 63, 1),
        primaryColorLight: const Color.fromRGBO(0, 48, 63, 0.5),
        secondaryHeaderColor: const Color.fromRGBO(89, 219, 174, 1),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(89, 219, 174, 1),
          selectionColor: Color.fromRGBO(89, 219, 174, 1),
          selectionHandleColor: Color.fromRGBO(0, 48, 63, 1),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final textController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
      ),
      body: Column(
        children: [
          LabeledInput(
            placeholder: 'Email',
            type: 'Email',
            textController: textController,
          ),
          LabeledInput(
              placeholder: 'Password',
              type: 'Password',
              textController: passwordController),
          Button(
            text: 'Login',
            onPressed: () {
              print(textController.text);
              print(passwordController.text);
            },
            type: 'secondary',
          ),
        ],
      ),
    );
  }
}
