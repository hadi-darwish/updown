import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Guest with ChangeNotifier {
  String _email = '';
  String _hostId = '';
  String _password = '';
  int _hostFloor = 0;

  String get email {
    print(_email + 'HIIIIIIIIIIIIIIIIII');
    return _email;
  }

  String get hostId => _hostId;
  String get password => _password;
  int get hostFloor => _hostFloor;

  Future<int> Enter(String email, String password, String hostId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(json.decode(prefs.getString('userData')!)['email']);
    final url = Uri.parse('${dotenv.env['BASE_URL']}guest');
    try {
      print('start');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'visitor_email': prefs.getString('userData') != null
                ? json.decode(prefs.getString('userData')!)['email']
                : email,
            'code': password,
            'host_id': hostId,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        // print(_email + 'HIIIIIIIIIIIIIIIIII');
        _email = responseData['visit']['visitor_email'];
        // print(_email + 'HIIIIIIIIIIIIIIIIII');
        _hostId = '${responseData['visit']['user_id']}';
        _password = responseData['visit']['code'];
        _hostFloor = responseData['floor'];
        prefs.setInt('hostId', responseData['visit']['user_id']);
        prefs.setInt('host_floor', responseData['floor']);
        print(_email + 'HIIIIIIIIIIIIIIIIII');
        print(prefs.getInt('host_floor'));
        // notifyListeners();
      }
      print(response.statusCode);
      notifyListeners();

      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
