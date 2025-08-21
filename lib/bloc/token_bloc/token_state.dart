import 'package:equatable/equatable.dart';

abstract class TokenState extends Equatable{
  const TokenState(); // Constructor

  @override
  List<Object?> get props => throw UnimplementedError();
}

//* Estado inicial generico para el TokenState
class AuthInitialState extends TokenState {}

//* Estados para validación de token
class AuthVerifyingToken extends TokenState {}
class AuthTokenValid extends TokenState {}
class AuthTokenInvalid extends TokenState {}
class AuthTokenError extends TokenState {
  final String messageError;
  const AuthTokenError(this.messageError);

  @override
  List<Object?> get props => [messageError];
}

//* Estados de validación para el inicio de sesión
class LoginSuccess extends TokenState {}