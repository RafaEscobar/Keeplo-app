import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:keeplo/services/api_service.dart';

class AppProvider extends ChangeNotifier{
  bool _isLogged = false;

  bool get isLogged => _isLogged;
  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  Future<int> verifyToken() async {
    try {
      Response response = await ApiService.request("/me");
      return response.statusCode!;
    } catch (e) {
      throw "Error al verificar token";
    }
  }
}