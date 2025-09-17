import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/models/user.dart';

abstract class AuthEvent {}

//* Evento para controlar valor de la variable -name- en el state
class NameChange extends AuthEvent {
  final String name;
  NameChange(this.name);
}

//* Evento para controlar valor de la variable -lastName- en el state
class LastNameChange extends AuthEvent {
  final String lastName;
  LastNameChange(this.lastName);
}

//* Evento para controlar valor de la variable -email- en el state
class EmailChange extends AuthEvent{
  final String email;
  EmailChange(this.email);
}

//* Evento para controlar valor de la variable -password- en el state
class PasswordChange extends AuthEvent{
  final String password;
  PasswordChange(this.password);
}

//* Evento para controlar el -status- del state
class AuthStatusChange extends AuthEvent {
  final AuthStatus staus;
  AuthStatusChange(this.staus);
}

//* Evento para controlar valor de la variable -user- en el state
class UserChangeAuth extends AuthEvent {
  final User user;
  UserChangeAuth(this.user);
}

//* Evento para lanzar petición login
class LoginSubmitted extends AuthEvent{}

//* Evento para lanzar petición register
class RegisterSubmitted extends AuthEvent{}
