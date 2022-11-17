import 'package:flutter/material.dart';

class ElevatorStatus extends StatelessWidget {
  const ElevatorStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text('Building Name'),
          Text('Elevator'),
          Icon(
            Icons.circle,
            color: Colors.green,
          ),
        ], // this will take up the space of the row
      ),
    );
  }
}
