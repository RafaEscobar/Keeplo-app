import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';
import 'package:keeplo/widgets/main/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = Responsive.isHorizontalTablet(context);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

    void processResponse(bool status) {
      (status) ?
        context.goNamed(DashboardScreen.routeName) :
        SimpleToast.error(context: context, message: "Credenciales incorrectas");
    }

    Future<void> login() async {
      try {
        bool status = false;
        //await Loader.runLoad(context: context, asyncFunction: () async => status = await context.read<AuthProvider>().login());
        if (!context.mounted) return;
        processResponse(status);
      } catch (e) {
        SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
      }
    }

    Future<void> validateForm() async {
      if (_formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
        await login();
      } else {
        SimpleToast.info(context: context, message: "¡Oops! Revisa los campos y vuelve a intentarlo.", size: 14, iconSize: 60);
      }
    }

    Widget headerMain = HeaderMain(
      imageUrl: "assets/pictures/login.png",
      title: "Iniciar sesión",
    );

    Widget footerMain = FooterMain(
      btnText: 'Iniciar sesión',
      callback: () async => await validateForm(),
    );

    Widget loginForm = LoginForm(callback: validateForm, formKey: _formKey,);

    Widget horizontalTabletBody = Row(
      children: [
        Expanded(child: headerMain),
        const SizedBox(width: 60),
        Expanded(
          child: Column(
            children: [
              loginForm,
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
        loginForm,
        const Spacer(),
        Visibility(visible: !isKeyboardOpen, child: footerMain)
      ],
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
                      child: isHorizontal ? horizontalTabletBody : regularBody
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
