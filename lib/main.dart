import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/routes/app_route.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initPreferences();
  await dotenv.load(fileName: '.env');

  runApp(
    _OrientationLockWrapper(child: const MyApp()),
  );
}

class _OrientationLockWrapper extends StatefulWidget {
  final Widget child;
  const _OrientationLockWrapper({required this.child});

  @override
  State<_OrientationLockWrapper> createState() => _OrientationLockWrapperState();
}

class _OrientationLockWrapperState extends State<_OrientationLockWrapper> {
  bool _didSetOrientation = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didSetOrientation) return;
    _didSetOrientation = true;

    final mq = MediaQuery.maybeOf(context);
    if (mq == null) return;

    final shortestSide = mq.size.shortestSide;
    final isTablet = shortestSide >= 600;

    if (!isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (_) => TokenBloc()),
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(create: (_) => VahulBloc()),
          BlocProvider(create: (_) => NewVahulBloc()),
          BlocProvider(create: (_) => ItemBloc()),
          BlocProvider(create: (_) => NewItemBloc()),
        ],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.getGoRoutes(navigatorKey),
        ),
      ),
    );
  }
}
