import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:keeplo/services/api_service.dart';

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

  bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
  bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;
  bool isHorizontalTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600 && MediaQuery.of(context).orientation == Orientation.landscape;

  double safeHeight(double base, double porcentaje, double max) {
    final result = base * porcentaje;
    return result > max ? max : result;
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