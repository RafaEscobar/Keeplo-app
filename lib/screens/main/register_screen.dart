import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'register-screen';

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = Responsive.isHorizontalTablet(context);

    Widget headerMain = HeaderMain(
      imageUrl: "assets/pictures/register.png",
      title: "Registrarme",
    );

    Widget footerMain = FooterMain(
      btnText: 'Crear cuenta',
      callback: () {},
      isLogin: false,
    );

    Widget horizontalTabletBody = Row(
      children: [
        Expanded(child: headerMain),
        const SizedBox(width: 60),
        Expanded(
          child: Column(
            children: [
              //LoginForm(),
              const SizedBox(height: 20),
              Spacer(),
              footerMain
            ],
          ),
        ),
      ],
    );

    Widget regularBody = Column(
      children: [
        headerMain,
        SizedBox(height: 20.h),
        //LoginForm(),
        const Spacer(),
        footerMain
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
          ),
        ),
      ),
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: isHorizontal ? horizontalTabletBody : regularBody
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}