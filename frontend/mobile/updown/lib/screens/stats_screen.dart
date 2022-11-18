import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:updown/providers/auth_provider.dart';
import 'package:updown/widgets/small_top.dart';
import 'package:updown/widgets/stat_box.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int tax = 0;
  int price_per_travel = 0;
  int total_travels = 0;
  int number_of_guests = 0;
  int total = 0;
  String status = 'OFF';

  @override
  void initState() {
    super.initState();

    Future<void> prices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(prefs.getString('token'));
      int? building_id = prefs.get('building_id') as int?;
      final url = Uri.parse('${dotenv.env['BASE_URL']}prices');
      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(
            {
              'building_id': building_id,
            },
          ),
        );
        final responseData = json.decode(response.body);
        setState(() {
          print(responseData['prices'][0]['price_per_travel']);
          tax = responseData['prices'][0]['tax'];
          price_per_travel = responseData['prices'][0]['price_per_travel'];
          total_travels = responseData['travels'];
          number_of_guests = responseData['guests'];
          total = (total_travels * price_per_travel) + tax;
          status = prefs.getBool('buildingStatus')! ? 'ON' : 'OFF';
        });
        // print(tax);
      } catch (error) {
        print(
            '8allllllllllllllllllllllllaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat');
        rethrow;
      }
    }

    prices();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          ElevatorStatus(),
          SizedBox(
            height: 20,
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
            ),
            childrenDelegate: SliverChildListDelegate(
              [
                StatBox(title: 'Travel cost', content: '\$$price_per_travel'),
                StatBox(title: 'Travel count', content: '$total_travels'),
                StatBox(title: 'Tax', content: '\$$tax'),
                StatBox(title: 'Guests', content: '$number_of_guests'),
                StatBox(title: 'Total', content: '\$$total'),
                StatBox(title: 'Travel cost', content: status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
