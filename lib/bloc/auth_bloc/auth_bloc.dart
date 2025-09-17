import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/models/user.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<NameChange>(_onNameChange);
    on<LastNameChange>(_onLastNameChange);
    on<EmailChange>(_onEmailChange);
    on<PasswordChange>(_onPasswordChange);
    on<AuthStatusChange>(_onAuthStatusChange);
    on<UserChangeAuth>(_onUserChange);
  }

  //* Método para realizar carga de inicio de sesión
  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
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

  //* Método para realizar carga de registro de cuenta
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

  //* Método para cambiar valor de la variable -name- del state
  void _onNameChange(NameChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(name: event.name));
  }

  //* Método para cambiar valor de la variable -lastName- del state
  void _onLastNameChange(LastNameChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  //* Método para cambiar valor de la variable -email- del state
  void _onEmailChange(EmailChange event, Emitter<AuthState> emit){
    emit(state.copyWith(email: event.email));
  }

  //* Método para cambiar valor de la variable -password- del state
  void _onPasswordChange(PasswordChange event, Emitter<AuthState> emit){
    emit(state.copyWith(password: event.password));
  }

  //* Método para cambiar el -status- del state
  void _onAuthStatusChange(AuthStatusChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      status: event.staus
    ));
  }

  //* Método para cambiar valor de la variable -user- del state
  void _onUserChange(UserChangeAuth event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      user: event.user
    ));
  }
}