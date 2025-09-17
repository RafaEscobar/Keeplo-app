import 'package:equatable/equatable.dart';

class SplashState extends Equatable{
  //* Bandera para controlar aparición de la SplashScreen
  final bool displayedSplash;

  const SplashState({
    this.displayedSplash = false
  });


  SplashState copyWith({
    bool? displayedSplash,
  }) => SplashState(
    displayedSplash: displayedSplash ?? this.displayedSplash
  );

  @override
  List<Object?> get props => [displayedSplash];
}