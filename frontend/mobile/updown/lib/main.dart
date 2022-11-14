import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
      ),
      body: Column(
        children: [
          const LabeledInput(placeholder: 'Email', type: 'Email'),
          const LabeledInput(placeholder: 'Password', type: 'Password'),
          Button(
            text: 'Login',
            onPressed: () {
              print('HIIIIIIIIIIIIII');
            },
            type: 'secondary',
          ),
        ],
      ),
    );
  }
}
