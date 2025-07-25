
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                name: RegisterScreen.routeName
              ),
              GoRoute(
                path: DashboardScreen.routeName,
                name: DashboardScreen.routeName,
                routes: [
                  //! Demas rutas de la app
                ]
              )
            ]
          )
        ]
      )
    ];
    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
      
    );
  }
}