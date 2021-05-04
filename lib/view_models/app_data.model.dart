import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  String _country = '';

  String get country => _country;

  void setCountry(String country) {
    _country = country;
    notifyListeners();
  }
}
