import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/screens/main/register_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/simple_button.dart';

class FooterMain extends StatelessWidget {
  const FooterMain({super.key, required this.btnText, required this.callback, this.isLogin = true});
  final String btnText;
  final Function() callback;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = context.isTabletLandscape;
    return Column(
      children: [
        SimpleButton(text: btnText, callback: callback),
        SizedBox(height: 16),
        Visibility(
          visible: isLogin,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: context.isTabletLandscape ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "¿Aún no tienes una cuenta?",
                    style: TextStyle(color: Colors.white, fontSize: isHorizontal ? 22 : Responsive.resize(size: 18.sp, reduction: .9)),
                  ),
                  GestureDetector(
                    onTap: () => context.goNamed(RegisterScreen.routeName),
                    child: Text(
                      "Crear una",
                      style: TextStyle(color: AppTheme.tertiary, fontSize: isHorizontal ? 22 : Responsive.resize(size: 18.sp, reduction: .9), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.isTabletLandscape ? 4: 16),
            ],
          )
        )
      ],
    );
  }
}