import 'package:keeplo/bloc/bloc_barrel.dart';

class ProviderBox {
  static List<BlocProvider> providers = [
    BlocProvider(create: (_) => SplashBloc(),),
    BlocProvider(create: (_) => TokenBloc(),),
    BlocProvider(create: (_) => AuthBloc(),),
    BlocProvider(create: (_) => VahulBloc())
  ];
}