import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthInitialState()) {
    on<VerifyTokenRequest>(_onVerifyTokenRequested);
  }

  Future<void> _onVerifyTokenRequested(VerifyTokenRequest event, Emitter<AuthState> emit) async {
    try {
      emit(AuthVerifyingToken());
      final response = await ApiService.request("/me", auth: Preferences.token);
      if (response.statusCode == 204) {
        emit(AuthTokenValid());
      } else {
        emit(AuthTokenInvalid());
      }
    } catch (e) {
      throw e.toString();
    }
  }

}