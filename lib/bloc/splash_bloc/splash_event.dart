
abstract class SplashEvent {
  const SplashEvent();
}

class UpdateIsLogged extends SplashEvent {
  UpdateIsLogged(this.isLogged);
  final bool isLogged;
}

class UpdateDisplayedSplash extends SplashEvent {
  UpdateDisplayedSplash(this.displayedSplash);
  final bool displayedSplash;
}