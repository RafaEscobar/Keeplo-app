import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class AuthProvider extends ChangeNotifier{
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  Future<bool> login() async {
    try {
      Response response = await ApiService.request(
        "/login",
        body: {
          "email": _emailController.text,
          "password": _passwordController.text
        }
      );
      if (response.statusCode == 200) {
        Preferences.token = response.data['data']['token'];
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw "Ocurrio un problema al iniciar sesión (${response.statusCode})";
      }
    } catch (e) {
      throw "Error: $e";
    }
  }

}