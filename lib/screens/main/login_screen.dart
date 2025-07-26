import 'package:flutter/material.dart';
import 'package:keeplo/widgets/main/header_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderMain(imageUrl: "assets/pictures/login.png", title: "Iniciar sesión",)
            ],
          ),
        ),
      )
    );
  }
}