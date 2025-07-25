import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/providers/app_provider.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  late AppProvider appProvider;
  late final AnimationController _entryController;
  late final AnimationController _exitController;
  late final Animation<double> _opacityIn;
  late final Animation<double> _opacityOut;

  Future<void> initLoad() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      //String token = Preferences.token;
      // login     
      (true) ? _onLoginSucces() : _onLogginFailure();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _onLoginSucces() async {
    _exitController.forward().then((value) => context.goNamed(DashboardScreen.routeName)) ;
  }

  void _onLogginFailure() => _exitController.forward().then((value) => context.goNamed(LoginScreen.routeName));

  @override
  void initState() {
    super.initState();
    appProvider = context.read<AppProvider>();
        _entryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _opacityIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _opacityOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeIn),
    );
    _entryController.forward().then((_) => initLoad());
  }

  @override
  void dispose() {
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
          child: Image.asset("assets/logos/logo.jpeg")
        ),
      ),
    );
  }
}