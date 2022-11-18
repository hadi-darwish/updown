import 'package:flutter/material.dart';
import 'package:updown/widgets/small_top.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: const [
          ElevatorStatus(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
