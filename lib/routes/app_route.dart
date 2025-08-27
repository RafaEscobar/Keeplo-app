
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/splash_bloc/splash_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_state.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/screens/main/register_screen.dart';
import 'package:keeplo/screens/main/splash_screen.dart';
import 'package:keeplo/services/preferences.dart';

class AppRoute {
  static RouterConfig<Object>? getGoRoutes(GlobalKey<NavigatorState> navigatorKey) {
    try {
      List<RouteBase> routes = [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => SplashScreen(),
          routes: [
            GoRoute(
              path: LoginScreen.routeName,
              name: LoginScreen.routeName,
              builder: (BuildContext context, GoRouterState state) => LoginScreen(),
              routes: [
                GoRoute(
                  path: RegisterScreen.routeName,
                  name: RegisterScreen.routeName,
                  builder: (BuildContext context, GoRouterState state) => RegisterScreen(),
                ),
              ]
            ),
            GoRoute(
              path: DashboardScreen.routeName,
              name: DashboardScreen.routeName,
              builder: (BuildContext context, GoRouterState state) => DashboardScreen(),
            )
          ]
        )
      ];
      return GoRouter(
        routes: routes,
        navigatorKey: navigatorKey,
        redirect: (context, state) {
          final SplashState appState = context.read<SplashBloc>().state;
          bool isDisplayedSplash = appState.displayedSplash; // Bandera temporal para evitar mostrar la splash en desarrollo
          if(isDisplayedSplash && state.matchedLocation == '/') {
            //* Si tenemos un token redireccionamos al dash, de lo contrario al login.
            return (Preferences.token.isNotEmpty) ? "/${DashboardScreen.routeName}" : "/${LoginScreen.routeName}";
          }
          return null;
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}