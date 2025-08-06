
abstract class AppEvent {
  const AppEvent();
}

class UpdateIsLogged extends AppEvent {
  UpdateIsLogged(this.isLogged);
  final bool isLogged;
}

class UpdateDisplayedSplash extends AppEvent {
  UpdateDisplayedSplash(this.displayedSplash);
  final bool displayedSplash;
}