import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keeplo/providers/app_provider.dart';
import 'package:keeplo/providers/auth_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(),),
        ChangeNotifierProvider(create: (_) => AuthProvider(),)
      ],
      builder: (_, __) {
        return ScreenUtilInit(
          designSize: Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp.router(
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoute.getGoRoutes(navigatorKey),
          ),
        );
      },
    );
  }
}