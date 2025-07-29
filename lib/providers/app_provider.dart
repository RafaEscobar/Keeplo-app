import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class AppProvider extends ChangeNotifier{
  bool _isLogged = false;
  bool _displayedSplash = false;

  bool get isLogged => _isLogged;
  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  bool get displayedSplash => _displayedSplash;
  set displayedSplash(bool value) {
    _displayedSplash = value;
    notifyListeners();
  }

  Future<int> verifyToken() async {
    try {
      Response response = await ApiService.request("/me", auth: Preferences.token);
      return response.statusCode!;
    } catch (e) {
      throw "Error al verificar token";
    }
  }
}