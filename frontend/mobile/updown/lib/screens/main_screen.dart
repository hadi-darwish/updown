import 'package:flutter/material.dart';
import 'package:updown/widgets/small_top.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: const [
          ElevatorStatus(),
        ],
      ),
    );
  }
}
