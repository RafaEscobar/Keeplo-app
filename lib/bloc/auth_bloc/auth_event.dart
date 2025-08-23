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

class LoginSubmitted extends AuthEvent{}