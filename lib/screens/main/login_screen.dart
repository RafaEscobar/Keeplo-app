import 'package:flutter/material.dart';
import 'package:keeplo/providers/app_provider.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';
import 'package:keeplo/widgets/main/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    final isHorizontalTablet = appProvider.isHorizontalTablet(context);
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
                child: isHorizontalTablet
                  ? Row(
                    spacing: 60,
                    children: [
                      Expanded(
                        child: HeaderMain(
                          imageUrl: "assets/pictures/login.png",
                          title: "Iniciar sesión",
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: LoginForm()),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      HeaderMain(
                        imageUrl: "assets/pictures/login.png",
                        title: "Iniciar sesión",
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: LoginForm(),
                      ),
                      const SizedBox(height: 140),
                    ],
                  ),
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