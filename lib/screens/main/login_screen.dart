import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';
import 'package:keeplo/widgets/main/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.primary,
        body: SafeArea(
          child: Stack(
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    HeaderMain(
                      imageUrl: "assets/pictures/login.png",
                      title: "Iniciar sesión",
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: LoginForm(),
                    ),
                  ],
                )
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: FooterMain(
                  btnText: 'Iniciar sesión',
                  callback: () {},
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}