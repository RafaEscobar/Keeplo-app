import 'package:equatable/equatable.dart';
import 'package:keeplo/models/user.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final AuthStatus status;
  final User? user;

  const AuthState({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.status = AuthStatus.initial,
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
      user: user ?? this.user
    );
  }

  @override
  List<Object?> get props => [name, lastName, email, password, status];
}
