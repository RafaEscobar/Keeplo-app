import 'package:equatable/equatable.dart';

class AppState extends Equatable{
  const AppState({
    this.isLogged = false,
    this.displayedSplash = false
  });

  final bool isLogged;
  final bool displayedSplash;

  AppState copyWith({
    bool? isLogged,
    bool? displayedSplash,
  }) => AppState(
    isLogged: isLogged ?? this.isLogged,
    displayedSplash: displayedSplash ?? this.displayedSplash
  );

  @override
  List<Object?> get props => [isLogged, displayedSplash];
}