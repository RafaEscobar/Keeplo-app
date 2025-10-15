import 'package:equatable/equatable.dart';
import 'package:keeplo/models/user.dart';

enum AuthStatus { initial, loading, success, failure, closedSession }

class AuthState extends Equatable {
  //* Información del usuario (login/register)
  final String name;
  final String lastName;
  final String email;
  final String password;
  final AuthStatus status; //* Status del State
  final User? user; //* Información del usuario logeado
  final String errorMessage; //* Mensaje de error para toast

  const AuthState({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.status = AuthStatus.initial,
    this.errorMessage = '',
    this.user
  });

  AuthState copyWith({
    String? name,
    String? lastName,
    String? email,
    String? password,
    AuthStatus? status,
    String? errorMessage,
    User? user
  }) {
    return AuthState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [name, lastName, email, password, status, user, errorMessage];
}
