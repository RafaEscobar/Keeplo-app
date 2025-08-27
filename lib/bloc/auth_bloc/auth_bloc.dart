import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/models/user.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    on<LoginSubmitted>(_onSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<NameChange>(_onNameChange);
    on<LastNameChange>(_onLastNameChange);
    on<EmailChange>(_onEmailChange);
    on<PasswordChange>(_onPasswordChange);
    on<AuthStatusChange>(_onAuthStatusChange);
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    final email = state.email;
    final password = state.password;

    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final response = await ApiService.request("/login", body: {"email": email, "password": password});
      await Future.delayed(const Duration(seconds: 1));

      if (response.statusCode == 200) {
        Preferences.token = response.data['data']['token']; // Guardamos el token recibido
        emit(state.copyWith(status: AuthStatus.success, user: User.fromJson(response.data['data']))); // Emitimos un status -success- y usuario
      } else {
        emit(state.copyWith(status: AuthStatus.failure, errorMessage: response.data['message'])); // Lanzamos un status -failure- de otro error
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
      throw Exception(e.toString());
    }
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<AuthState> emit) async {
    final String name = state.name;
    final String lastName = state.lastName;
    final String email = state.email;
    final String password = state.password;

    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final response = await ApiService.request(
        '/register',
        body: {
          'name': name,
          'last_name': lastName,
          'email': email,
          'password': password
        }
      );
      if (response.statusCode == 201) {
        Preferences.token = response.data['data']['token']; // Guardamos el token recibido
        emit(state.copyWith(status: AuthStatus.success, user: User.fromJson(response.data['data']))); // Emitimos un status -success- y usuario
      } else {
        emit(state.copyWith(status: AuthStatus.failure, errorMessage: response.data['message'])); // Lanzamos un status -failure-
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  void _onNameChange(NameChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      name: event.name
    ));
  }

  void _onLastNameChange(LastNameChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      lastName: event.lastName
    ));
  }

  void _onEmailChange(EmailChange event, Emitter<AuthState> emit){
    emit(state.copyWith(
      email: event.email
    ));
  }

  void _onPasswordChange(PasswordChange event, Emitter<AuthState> emit){
    emit(state.copyWith(
      password: event.password
    ));
  }

  void _onAuthStatusChange(AuthStatusChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      status: event.staus
    ));
  }
}