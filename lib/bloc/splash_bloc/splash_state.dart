import 'package:equatable/equatable.dart';

class SplashState extends Equatable{
  const SplashState({
    this.isLogged = false,
    this.displayedSplash = false
  });

  final bool isLogged;
  final bool displayedSplash;

  SplashState copyWith({
    bool? isLogged,
    bool? displayedSplash,
  }) => SplashState(
    isLogged: isLogged ?? this.isLogged,
    displayedSplash: displayedSplash ?? this.displayedSplash
  );

  @override
  List<Object?> get props => [isLogged, displayedSplash];
}