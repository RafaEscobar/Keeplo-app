import 'package:keeplo/bloc/auth_bloc/auth_state.dart';

abstract class AuthEvent {}

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

class LoginSubmitted extends AuthEvent{}