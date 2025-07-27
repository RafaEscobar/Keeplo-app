import 'package:flutter/material.dart';
import 'package:keeplo/providers/app_provider.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/simple_button.dart';
import 'package:provider/provider.dart';

class FooterMain extends StatelessWidget {
  const FooterMain({super.key, required this.btnText, required this.callback, this.isLogin = true});
  final String btnText;
  final Function() callback;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    bool isTablet = context.read<AppProvider>().isTablet(context);
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
                  Text(
                    "¿Aún no tienes una cuenta?",
                    style: TextStyle(color: Colors.white, fontSize: isTablet ? 22 : 16),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Crear una",
                      style: TextStyle(color: AppTheme.error, fontSize: isTablet ? 22 : 16, fontWeight: FontWeight.bold),
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