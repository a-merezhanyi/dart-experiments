import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<dynamic> _authenticate(
      String email, String password, String urlSegment) async {
    final Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAmsforfGrOGs19AbAFe6-8PPCL3Q64cCs');
    dynamic response;
    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      if (res.statusCode >= 400) {
        response = json.decode(res.body);
        throw HttpException('Error occurred!');
      } else {
        response = json.decode(res.body);
      }
    } catch (error) {
      throw error;
    }

    return response;
  }

  Future<void> signup(String email, String password) async {
    final response = await _authenticate(
      email,
      password,
      'signUp',
    );

    print('>>> SIGN UP');
    print(response);
    return response;
  }

  Future<void> signin(String email, String password) async {
    final response = await _authenticate(
      email,
      password,
      'signInWithPassword',
    );
    print('>>> SIGN IN');
    print(response);
    return response;
  }
}
