import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/simple_button.dart';

class FooterMain extends StatelessWidget {
  const FooterMain({super.key, required this.btnText, required this.callback, this.isLogin = true});
  final String btnText;
  final Function() callback;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleButton(text: btnText, callback: callback),
        Visibility(
          visible: isLogin,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿Aún no tienes una cuenta?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Crear una",
                      style: TextStyle(color: AppTheme.error, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          )
        )
      ],
    );
  }
}