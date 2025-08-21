import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/services/api_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    try {
      final response = await ApiService.request(
        "/login",
        body: {
          "email": state.email,
          "password": state.password
        }
      );
      if (response.statusCode == 204) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } catch (e) {
      throw e.toString();
    }
  }

}