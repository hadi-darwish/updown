import 'package:flutter/material.dart';

class ElevatorStatus extends StatelessWidget {
  const ElevatorStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 15,
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(197, 197, 197, 1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Building Name',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Elevator  ',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  )),
              const Icon(
                Icons.circle,
                color: Colors.green,
                size: 14,
              ),
            ],
          )
        ], // this will take up the space of the row
      ),
    );
  }
}
