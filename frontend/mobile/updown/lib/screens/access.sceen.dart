import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/small_top.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  String password = 'password';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          const ElevatorStatus(),
          const SizedBox(
            height: 20,
          ),
          Button(
              text: 'request new password', onPressed: () {}, type: 'primary'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: screenWidth * 0.9,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(197, 197, 197, 1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Guest Password'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  password,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Button(
              text: 'copy',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: password));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Copied to Clipboard"),
                ));
              },
              type: 'third'),
          Button(text: 'share', onPressed: () {}, type: 'secondary'),
        ],
      ),
    );
  }
}
