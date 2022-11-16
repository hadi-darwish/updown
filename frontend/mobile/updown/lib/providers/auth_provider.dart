import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late String _userId;
  late Timer _authTimer;

  String get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return '';
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
      final responseData = json.decode(response.body);
      print(responseData);
      _token = responseData['authorisation'] != null
          ? responseData['authorisation']['token']
          : '';
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
