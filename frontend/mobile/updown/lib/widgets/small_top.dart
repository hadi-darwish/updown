import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:updown/providers/building_provider.dart';

class ElevatorStatus extends StatelessWidget {
  const ElevatorStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final building = Provider.of<Building>(context);
    print("samiraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" +
        '${building.numberOfFloors}');
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
            '${building.building['name']}',
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
              Icon(
                Icons.circle,
                color: building.isOn == 0 ? Colors.red : Colors.green,
                size: 14,
              ),
            ],
          )
        ], // this will take up the space of the row
      ),
    );
  }
}
