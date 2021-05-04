import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  String _country = '';
  String _email = '';
  String _token = '';

  String get country => _country;
  String get email => _email;
  String get token => _token;

  void setCountry(String country) {
    _country = country;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}
