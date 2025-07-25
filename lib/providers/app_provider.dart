import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  bool _isLogged = false;

  bool get isLogged => _isLogged;
  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }
}