import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/routes/app_route.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initPreferences();
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc(),),
          BlocProvider(create: (_) => TokenBloc(),),
          BlocProvider(create: (_) => AuthBloc(),),
          BlocProvider(create: (_) => VahulBloc()),
          BlocProvider(create: (_) => NewVahulBloc(),),
          BlocProvider(create: (_) => ItemBloc(),)
        ],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.getGoRoutes(navigatorKey),
        ),
      )
    );
  }
}