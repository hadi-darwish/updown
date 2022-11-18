import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updown/providers/guest_provider.dart';

class Building with ChangeNotifier {
  late Map<String, dynamic> _building;
  late int _numberOfFloors;
  late int _isOn;

  Map<String, dynamic> get building {
    if (_building.isNotEmpty) {
      return _building;
    }
    return {};
  }

  int get numberOfFloors {
    if (_numberOfFloors != 0) {
      return _numberOfFloors;
    }
    return 0;
  }

  int get isOn {
    return _isOn;
  }

  Future<int> getBuilding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('start-----------------------------------------');
    // print(json.decode(prefs.getString('userData')!)['id']);
    final url = Uri.parse('${dotenv.env['BASE_URL']}building_user');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'user_id': prefs.getString('userData') != null
                ? json.decode(prefs.getString('userData')!)['id']
                : prefs.get('hostId'),
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      _building = responseData['building'] ?? {};
      _numberOfFloors = responseData['building']['number_of_floors'] ?? 0;
      prefs.setInt('numberOfFloors', _numberOfFloors);
      _isOn = responseData['building']['is_on'] ?? 0;
      print('----------------------------');
      print(_numberOfFloors);
      print('----------------------------');
      notifyListeners();
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
