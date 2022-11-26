import 'package:flutter/material.dart';
import 'package:updown/screens/main_screen.dart';
import 'package:updown/widgets/top_bar.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: TopBar(screenHeight: screenHeight), body: const MainPage());
  }
}
