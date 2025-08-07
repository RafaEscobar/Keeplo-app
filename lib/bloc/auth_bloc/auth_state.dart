import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  const AuthState(); // Constructor

  @override
  List<Object?> get props => throw UnimplementedError();
}

//* Estado inicial generico para el AuthState
class AuthInitialState extends AuthState {}

//* Estados para validación de token
class AuthVerifyingToken extends AuthState {}
class AuthTokenValid extends AuthState {}
class AuthTokenInvalid extends AuthState {}
class AuthTokenError extends AuthState {
  final String messageError;
  const AuthTokenError(this.messageError);

  @override
  List<Object?> get props => [messageError];
}

//* Estados de validación para el inicio de sesión
class LoginSuccess extends AuthState {}