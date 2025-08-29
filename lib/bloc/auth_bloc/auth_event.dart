import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/models/user.dart';

abstract class AuthEvent {}

class NameChange extends AuthEvent {
  final String name;
  NameChange(this.name);
}

class LastNameChange extends AuthEvent {
  final String lastName;
  LastNameChange(this.lastName);
}

class EmailChange extends AuthEvent{
  final String email;
  EmailChange(this.email);
}

class PasswordChange extends AuthEvent{
  final String password;
  PasswordChange(this.password);
}

class LoadingChange extends AuthEvent {
  final bool isLoading;
  LoadingChange(this.isLoading);
}

class AuthStatusChange extends AuthEvent {
  final AuthStatus staus;
  AuthStatusChange(this.staus);
}

class UserChange extends AuthEvent {
  final User user;
  UserChange(this.user);
}

class LoginSubmitted extends AuthEvent{}
class RegisterSubmitted extends AuthEvent{}
