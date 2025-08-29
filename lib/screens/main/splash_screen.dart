import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/splash_bloc/splash_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_event.dart';
import 'package:keeplo/bloc/token_bloc/token_bloc.dart';
import 'package:keeplo/bloc/token_bloc/token_event.dart';
import 'package:keeplo/bloc/token_bloc/token_state.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/utils/simple_toast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  late final AnimationController _entryController;
  late final AnimationController _exitController;
  late final Animation<double> _opacityIn;
  late final Animation<double> _opacityOut;

  //* Método para verificar estado de la sesión
  Future<void> initLoad() async {
    // Con esto nos aseguramos que la splash no se muestre en desarrollo
    context.read<SplashBloc>().add(UpdateDisplayedSplash(true));
    try {
      // Verificamos sí tenemos un token que validar.
      if(Preferences.token.isNotEmpty) {
        context.read<TokenBloc>().add(VerifyTokenRequest()); // Validamos el token.
      } else {
        _redirectToLogin(); // Redireccionamos al login si es que no tenemos token.
      }
    } catch (e) {
      SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
    }
  }

  //? Ejecución de animación de salida y redirección a Dashboard
  void _redirectToDashboard() => _exitController.forward().then((value) => context.goNamed(DashboardScreen.routeName)) ;

  //? Ejecución de animación de salida y redirección al Login
  void _redirectToLogin() => _exitController.forward().then((value) => context.goNamed(LoginScreen.routeName));

  @override
  void initState() {
    super.initState();
    //? Controladores para la animacion
    _entryController = AnimationController(vsync: this, duration: const Duration(seconds: 1),);
    _exitController = AnimationController(vsync: this,duration: const Duration(seconds: 1),);

    //? Gestores de animación
    _opacityIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut),);
    _opacityOut = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn),);

    //? Ejecución de animación de entrada
    _entryController.forward().then((_) => initLoad());
  }

  @override
  void dispose() {
    _entryController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<TokenBloc, TokenState>(
        listener: (context, state) {
          if (state.status == TokenStatus.validated) {
            //context.read<AuthBloc>().add(UserChange(user));
            _redirectToDashboard(); // Sí el token esta validado redireccionamos al dash
          } else if (state.status == TokenStatus.failure) {
            _redirectToLogin(); // Sí el token no es valido redireccionamos al login
          }
        },
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_entryController, _exitController]),
            builder: (_, child) {
              double opacity = (_exitController.status != AnimationStatus.dismissed)
                  ? _opacityOut.value
                  : _opacityIn.value;
              return Opacity(
                opacity: opacity,
                child: child,
              );
            },
            child: Image.asset(
              "assets/logos/logo.jpeg",
              width: 200,
            )
          ),
        ),
      )
    );
  }
}