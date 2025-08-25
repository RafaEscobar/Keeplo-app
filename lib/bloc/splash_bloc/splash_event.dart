
abstract class SplashEvent {
  const SplashEvent();
}

class UpdateDisplayedSplash extends SplashEvent {
  UpdateDisplayedSplash(this.displayedSplash);
  final bool displayedSplash;
}