import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updown/providers/building_provider.dart';
import 'package:updown/widgets/dropdown.dart';
import 'package:updown/widgets/elevator_button.dart';
import 'package:updown/widgets/small_top.dart';
import 'package:updown/widgets/text_box.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int floors = 0;
  int? host_floor;
  int? number_of_floors;
  int from_floor = 0;
  String mode = '';
  // int value = 0;

  // int hostFloor() async {
  @override
  void initState() {
    super.initState();
    Future<void> hostFlooree() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? host_floor2 = prefs.getInt('host_floor');
      int? number_of_floors2 = prefs.getInt('numberOfFloors');
      String mode2 = prefs.getString('mode') ?? 'guest';
      setState(() {
        host_floor = host_floor2;
        number_of_floors = number_of_floors2;
        mode = mode2;
      });
    }

    hostFlooree();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ElevatorStatus(),
              const SizedBox(
                height: 20,
              ),
              // const TextBox(
              //   text1: 'Current Floor',
              //   text2: '1',
              //   theme: 'secondary',
              // ),

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                width: screenWidth * 0.90,
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Current Floor',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButton(
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        hint: const Text('Select Current Floor'),
                        value: from_floor,
                        items: mode == 'guest'
                            ? [
                                const DropdownMenuItem(
                                  value: 0,
                                  child: Text('GF'),
                                ),
                                DropdownMenuItem(
                                  value: host_floor,
                                  child: Text('$host_floor'),
                                ),
                              ]
                            : x,
                        onChanged: (value) {
                          setState(() {
                            from_floor = value as int;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.07,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Request Floor'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // This is the main part of the app
              // It is a container that contains a list of buttons
              // Each button represents a floor
              // When a button is pressed, the app will send a request to the server
              // The server will then send a response to the app
              // The app will then update the UI to reflect the new state

              SingleChildScrollView(
                child: FloorsGrid(
                  x: from_floor,
                  screenWidth: screenWidth,
                  mode: mode,
                  host_floor: host_floor ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloorsGrid extends StatelessWidget {
  const FloorsGrid({
    super.key,
    required this.x,
    required this.screenWidth,
    required this.mode,
    required this.host_floor,
  });

  final int x;
  final double screenWidth;
  final String mode;
  final int host_floor;

  @override
  Widget build(BuildContext context) {
    final y = Provider.of<Building>(context).numberOfFloors;
    print('--------dd-------');
    print(y);
    print('------dd---------');
    // final z = y.numberOfFloors;
    int h = y + 1;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: h,
      padding: EdgeInsets.only(
        left: screenWidth * 0.07,
        right: screenWidth * 0.07,
      ),
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        h -= 1;
        Widget d = ElevatorButton(
          floorNumber: h,
          currentFloor: x,
          disabled:
              mode == 'guest' && (h != (host_floor) && h != 0) ? true : false,
        );

        return d;
      },
    );
  }
}
