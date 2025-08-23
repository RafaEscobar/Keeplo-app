import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/services/api_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    on<LoginSubmitted>(_onSubmitted);
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
        emit(state.copyWith(status: AuthStatus.success));
      } else {
        emit(state.copyWith(status: AuthStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
    }
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