import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';
import 'package:keeplo/widgets/main/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>() ;

  Future<void> login() async {
    try {
      context.read<AuthBloc>().add(LoginSubmitted());
    } catch (e) {
      SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
    }
  }

  Future<void> validateForm() async {
    if (formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      await login();
    } else {
      SimpleToast.info(context: context, message: "¡Oops! Revisa los campos y vuelve a intentarlo.", size: 14, iconSize: 60);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = Responsive.isHorizontalTablet(context);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    Widget headerMain = HeaderMain(
      imageUrl: "assets/pictures/login.png",
      title: "Iniciar sesión",
    );

    Widget footerMain = FooterMain(
      btnText: 'Iniciar sesión',
      callback: () async => await validateForm(),
    );

    Widget loginForm = LoginForm(callback: validateForm, formKey: formKey,);

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
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.goNamed(DashboardScreen.routeName);
            } else if (state is LoginFailed) {
              SimpleToast.error(context: context, message: "Credenciales incorrectas");
            }
          },
          child: SafeArea(
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
      ),
    );
  }
}
