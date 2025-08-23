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
    bool isHorizontal = Responsive.isHorizontalTablet(context);
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
      children: [
        Expanded(child: headerMain),
        const SizedBox(width: 60),
        Expanded(
          child: Column(
            children: [
              form,
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
              context.goNamed(DashboardScreen.routeName);
            } else if (state.status == AuthStatus.failure) {
              SimpleToast.error(context: context, message: isLogin ? "Credenciales incorrectas" : "Ocurrio un error al crear la cuenta", size: isLogin ? 18 : 14);
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
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: isHorizontal ? horizontalTabletBody : regularBody,
                            ),
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