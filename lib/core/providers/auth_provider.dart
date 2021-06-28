import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expireTime;
  String _userId;

  Future<void> signUp(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBjmEbu_oIxk-QxKrYK-gmJaOnbLOda4wg';
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    try {
      final response = await Dio().post(url, data: body);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBjmEbu_oIxk-QxKrYK-gmJaOnbLOda4wg';
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    try {
      final response = await Dio().post(url, data: body);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
