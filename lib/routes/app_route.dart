
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/splash_bloc/splash_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_state.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/screens/main/register_screen.dart';
import 'package:keeplo/screens/main/splash_screen.dart';

class AppRoute {
  static RouterConfig<Object>? getGoRoutes(GlobalKey<NavigatorState> navigatorKey) {
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
              GoRoute(
                path: DashboardScreen.routeName,
                name: DashboardScreen.routeName,
                builder: (BuildContext context, GoRouterState state) => DashboardScreen(),
              )
            ]
          )
        ]
      )
    ];
    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        final SplashState appState = context.read<SplashBloc>().state;
        bool isDisplayedSplash = appState.displayedSplash;
        if(isDisplayedSplash && state.matchedLocation == '/') {
          return (appState.isLogged) ? "/${DashboardScreen.routeName}" : "/${LoginScreen.routeName}";
        }
        return null;
      },
    );
  }
}