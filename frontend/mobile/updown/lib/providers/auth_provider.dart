import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  late String _token;
  late Map<String, dynamic> _user;
  late Timer _authTimer;

  String get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  Map<String, dynamic> get user {
    if (_user.isNotEmpty) {
      return _user;
    }
    return {};
  }

  Future<int> signIn(String email, String password) async {
    final url = Uri.parse('${dotenv.env['BASE_URL']}login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      try {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData['authorisation'] != null) {
          _token = responseData['authorisation']['token'];

          _user = responseData['user'] ?? {};

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', responseData['authorisation']['token']);
          prefs.setInt('id', responseData['user']['id']);
          prefs.setString('email', responseData['user']['email']);
          if (_user.isNotEmpty) {
            final userData = json.encode(responseData['user']);
            prefs.setString('userData', userData);
          }
          notifyListeners();
          print(response.statusCode);
        } else {
          return 0;
        }

        return response.statusCode;
      } catch (error) {
        rethrow;
      }
    } catch (error) {
      final responseData = '';
      return 0;
    }
  }

  Future<void> logout() async {
    _token = '';
    _user = {};
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
