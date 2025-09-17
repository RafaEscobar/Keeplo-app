
//* Clase abstracta base
abstract class SplashEvent {}

//* Evento para cambiar el valor de la variable -displayedSplash- del state
class UpdateDisplayedSplash extends SplashEvent {
  UpdateDisplayedSplash(this.displayedSplash);
  final bool displayedSplash;
}