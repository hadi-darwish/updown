import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Travel with ChangeNotifier {
  late Map<String, dynamic> _travel;

  Map<String, dynamic> get travel {
    if (_travel.isNotEmpty) {
      return _travel;
    }
    return {};
  }

  Future<int> requestTravel(int toFloor, int fromFloor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('${dotenv.env['BASE_URL']}travel');

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
            'from_floor': fromFloor,
            'to_floor': toFloor,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      _travel = responseData['travel'] ?? {};
      notifyListeners();
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
