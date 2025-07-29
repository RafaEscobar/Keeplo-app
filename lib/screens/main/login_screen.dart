import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    Widget headerMain = HeaderMain(
      imageUrl: "assets/pictures/login.png",
      title: "Iniciar sesión",
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      child: isHorizontalTablet
                          ? Row(
                              children: [
                                Expanded(child: headerMain),
                                const SizedBox(width: 60),
                                Expanded(
                                  child: Column(
                                    children: [
                                      LoginForm(),
                                      const SizedBox(height: 20),
                                      Spacer(),
                                      FooterMain(
                                        btnText: 'Iniciar sesión',
                                        callback: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                headerMain,
                                SizedBox(height: 20.h),
                                LoginForm(),
                                const Spacer(),
                                FooterMain(
                                  btnText: 'Iniciar sesión',
                                  callback: () {},
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
