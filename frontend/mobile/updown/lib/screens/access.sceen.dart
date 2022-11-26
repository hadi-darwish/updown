import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:updown/providers/auth_provider.dart';
import 'package:updown/providers/building_provider.dart';
import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/small_top.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  String password = 'password';
  bool isLoading = false;
  Future<void> share(id, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mode', 'user');
    await Share.share(
        'Hey, I have invited you to join my building on UpDown.\n Here is the Host ID: $id  \n and Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Building>(context).getBuilding();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
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
                  text: 'request new password',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? token = prefs.getString('token');
                    final url = Uri.parse('${dotenv.env['BASE_URL']}visit');
                    final response = http.get(
                      url,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                    ).then((value) => {
                          if (value.statusCode == 200)
                            {
                              setState(
                                () {
                                  password =
                                      json.decode(value.body)['visit']['code'];
                                  print(password);
                                },
                              ),
                              setState(() {
                                isLoading = false;
                              })
                            }
                          else
                            {
                              setState(() {
                                isLoading = false;
                              }),
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'An error occured, please try again later'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              )
                            }
                        });
                  },
                  type: 'primary'),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Copied to Clipboard"),
                    ));
                  },
                  type: 'third'),
              Button(
                  text: 'share',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int id = prefs.getInt('id') as int;
                    share(id, password);
                  },
                  type: 'secondary'),
              Button(
                  text: 'guest mode',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('mode', 'user');
                    Navigator.pushNamed(context, '/guestModeLogin');
                  },
                  type: 'secondary'),
              Button(
                  text: 'Logout',
                  onPressed: () {
                    Auth().logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/signIn', (route) => false);
                  },
                  type: 'primary')
            ],
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
