import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.currentIndex, required this.onTaped});

  final int currentIndex;
  final Function(int) onTaped;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ((value) {
        widget.onTaped(value);
      }),
      // new, this is where you handle the onTap of the items
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: ('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: ('Stats'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility),
          label: ('Access'),
        ),
      ],
      selectedIconTheme: IconThemeData(
          color: Theme.of(context).secondaryHeaderColor, size: 35),
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).secondaryHeaderColor,
      unselectedItemColor: const Color.fromRGBO(255, 255, 255, 0.25),
      unselectedIconTheme: const IconThemeData(
          size: 35, color: Color.fromRGBO(255, 255, 255, 0.25)),

      currentIndex: widget.currentIndex,
      // this will be set when a new tab is tapped

      type: BottomNavigationBarType.fixed,
    );
  }
}
