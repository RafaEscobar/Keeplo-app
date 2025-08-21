import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/token_bloc/token_event.dart';
import 'package:keeplo/bloc/token_bloc/token_state.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState>{
  TokenBloc() : super(AuthInitialState()) {
    on<VerifyTokenRequest>(_onVerifyTokenRequested);
  }

  Future<void> _onVerifyTokenRequested(VerifyTokenRequest event, Emitter<TokenState> emit) async {
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