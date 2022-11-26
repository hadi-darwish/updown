import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Travel with ChangeNotifier {
  late Map<String, dynamic> _travel;
  int _onFloor = 3;

  Map<String, dynamic> get travel {
    if (_travel.isNotEmpty) {
      return _travel;
    }
    return {};
  }

  int get onFloor {
    return _onFloor;
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

  void AnimationFrom(int toFloor, int fromFloor, context) {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (fromFloor > _onFloor) {
        _onFloor++;
        notifyListeners();
      } else if (fromFloor < _onFloor) {
        _onFloor--;
        notifyListeners();
      } else {
        timer.cancel();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Travel Arrived'),
              content: const Text('Press OK when You are in the Elevator!!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    AnimationTo(toFloor, fromFloor);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void AnimationTo(int toFloor, int fromFloor) {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (toFloor > _onFloor) {
        _onFloor++;
        notifyListeners();
      } else if (toFloor < _onFloor) {
        _onFloor--;
        notifyListeners();
      } else {
        timer.cancel();
        return;
      }
    });
  }
}
