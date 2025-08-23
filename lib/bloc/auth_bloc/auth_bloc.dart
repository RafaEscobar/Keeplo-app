import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/services/api_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    on<LoginSubmitted>(_onSubmitted);
    on<EmailChange>(_onEmailChange);
    on<PasswordChange>(_onPasswordChange);
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await ApiService.request(
        "/login",
        body: {
          "email": state.email,
          "password": state.password
        }
      );
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(isLoading: true));
      if (response.statusCode == 204) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } catch (e) {
      throw e.toString();
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
}