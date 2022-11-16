import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;
  late Timer _authTimer;

  Future<void> signIn(String email, String password) async {
    print('start');
    final url = Uri.parse('${dotenv.env['BASE_URL']}login');
    print(url);
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
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print(error);
    }
  }
}
