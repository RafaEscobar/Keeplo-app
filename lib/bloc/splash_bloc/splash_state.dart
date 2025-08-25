import 'package:equatable/equatable.dart';

class SplashState extends Equatable{
  const SplashState({
    this.displayedSplash = false
  });

  final bool displayedSplash;

  SplashState copyWith({
    bool? displayedSplash,
  }) => SplashState(
    displayedSplash: displayedSplash ?? this.displayedSplash
  );

  @override
  List<Object?> get props => [displayedSplash];
}