import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/main/footer_main.dart';
import 'package:keeplo/widgets/main/header_main.dart';

class AuthTemplateScreen extends StatelessWidget {
  const AuthTemplateScreen({
    super.key,
    this.isLogin = true,
    required this.action,
    required this.form,
  });
  final bool isLogin;
  final Future<void> Function() action;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isHorizontal = context.isTabletLandscape;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    Widget headerMain = HeaderMain(
      imageUrl: isLogin ? "assets/pictures/login.png" : "assets/pictures/register.png",
      title: isLogin ? "Iniciar sesión" : "Registrarme",
    );

    Widget footerMain = FooterMain(
      isLogin: isLogin,
      btnText: isLogin ? 'Iniciar sesión' : 'Crear cuenta',
      callback: () async => await action(),
    );

    Widget horizontalTabletBody = Row(
      spacing: 40,
      children: [
        //Expanded(child: headerMain),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            "assets/pictures/cover.png",
            width: size.width * .54,
            height: size.height * .9,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              form,
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
        form,
        const Spacer(),
        Visibility(visible: !isKeyboardOpen, child: footerMain)
      ],
    );


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(didPop) return;
        if (!isLogin) context.goNamed(LoginScreen.routeName);
      },
      child: Scaffold(
        backgroundColor: AppTheme.primary,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              context.goNamed(DashboardScreen.routeName); // Sí la autenticación (login o register) es valida redireccionamos al dash
            } else if (state.status == AuthStatus.failure) {
              // Lanzamos toast de autenticación incorrecta y reiniciamos status de autenticación
              SimpleToast.error(context: context, message: context.read<AuthBloc>().state.errorMessage, size: isLogin ? 18 : 14);
              context.read<AuthBloc>().add(AuthStatusChange(AuthStatus.initial));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                              child: isHorizontal ? horizontalTabletBody : regularBody,
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state.status == AuthStatus.loading)
                  Positioned.fill(
                    child: Container(
                      color: AppTheme.primary.withAlpha(200),
                      child: const Center(child: CircularProgressIndicator(backgroundColor: AppTheme.secondary,)),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}