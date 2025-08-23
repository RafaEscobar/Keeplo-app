import 'package:equatable/equatable.dart';

class AuthState extends Equatable{
  const AuthState({
    this.email = '',
    this.password = '',
    this.isLoading = false
  });
  final String email;
  final String password;
  final bool isLoading;

  AuthState copyWith({
    String? email,
    String? password,
    bool? isLoading
  }) => AuthState(
    email: email ?? this.email,
    password: password ?? this.password,
    isLoading: isLoading ?? this.isLoading
  );

  @override
  List<Object?> get props => [email, password, isLoading];
}

class LoginSuccess extends AuthState {}
class LoginFailed extends AuthState {}