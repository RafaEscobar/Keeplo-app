import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    bool isHorizontal = Responsive.isHorizontalTablet(context);
    return Column(
      children: [
        SimpleButton(text: btnText, callback: callback),
        Visibility(
          visible: isLogin,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Aún no tienes una cuenta?",
                    style: TextStyle(color: Colors.white, fontSize: isHorizontal ? 22 : Responsive.resize(size: 16.sp, reduction: .9)),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Crear una",
                      style: TextStyle(color: AppTheme.error, fontSize: isHorizontal ? 22 : Responsive.resize(size: 16.sp, reduction: .9), fontWeight: FontWeight.bold),
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