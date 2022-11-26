import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updown/providers/guest_provider.dart';

class CurrentFloor extends StatefulWidget {
  const CurrentFloor({super.key, required this.mode});
  final String mode;

  @override
  State<CurrentFloor> createState() => _CurrentFloorState();
}

class _CurrentFloorState extends State<CurrentFloor> {
  int? host_floor;
  int? number_of_floors;
  int value = 0;

  // int hostFloor() async {
  @override
  void initState() {
    super.initState();
    Future<void> hostFlooree() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? host_floor2 = prefs.getInt('host_floor');
      int? number_of_floors2 = prefs.getInt('numberOfFloors');
      setState(() {
        host_floor = host_floor2;
        number_of_floors = number_of_floors2;
      });
    }

    hostFlooree();
  }

  @override
  Widget build(BuildContext context) {
    // hostFlooree();
    List<DropdownMenuItem<Object>> x = [];
    x.add(
      const DropdownMenuItem(
        value: 0,
        child: Text('GF'),
      ),
    );
    for (var i = 1; i <= (number_of_floors ?? 2); i++) {
      DropdownMenuItem<Object> item = DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      );
      x.add(item);
    }

    // print();

    return DropdownButton(
        items: widget.mode == 'guest'
            ? [
                const DropdownMenuItem(
                  value: 0,
                  child: Text('GF'),
                ),
                DropdownMenuItem(
                  value: host_floor,
                  child: Text('guest'),
                ),
              ]
            : x,
        onChanged: (value) {
          SharedPreferences.getInstance().then((prefs) {
            prefs.setInt('from_floor', value as int);
          });
          print(value);
        });
  }
}
