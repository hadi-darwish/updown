import 'package:flutter/material.dart';
import 'package:updown/screens/main_screen.dart';
import 'package:updown/widgets/nav_bar.dart';
import 'package:updown/widgets/top_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(screenHeight: screenHeight),
      body: IndexedStack(
        index: selectedPage,
        children: [
          MainPage(),
          Container(
            child: const Text('Stats'),
          ),
          Container(
            child: const Text('Settings'),
          ),
        ],
      ),
      bottomNavigationBar:
          NavBar(currentIndex: selectedPage, onTaped: onTabTapped),
    );
  }

  void onTabTapped(int currentIndex) {
    setState(() {
      selectedPage = currentIndex;
    });
  }
}
