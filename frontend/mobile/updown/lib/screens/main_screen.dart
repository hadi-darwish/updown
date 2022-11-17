import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:updown/providers/building_provider.dart';
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
  // @override
  // void initState() {

  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int x = 0;
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
              const TextBox(
                text1: 'Current Floor',
                text2: '1',
                theme: 'secondary',
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
                child: FloorsGrid(x: x, screenWidth: screenWidth),
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
  });

  final int x;
  final double screenWidth;

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
        );

        return d;
      },
    );
  }
}
