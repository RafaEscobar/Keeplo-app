import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final String email;
  final String password;
  final AuthStatus status;

  const AuthState({
    this.email = '',
    this.password = '',
    this.status = AuthStatus.initial,
  });

  AuthState copyWith({
    String? email,
    String? password,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}
