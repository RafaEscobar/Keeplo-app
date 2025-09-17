//* Clase abstracta base
abstract class TokenEvent {
  const TokenEvent();
}

//* Evento para validar token actual
class VerifyTokenRequest extends TokenEvent {}
