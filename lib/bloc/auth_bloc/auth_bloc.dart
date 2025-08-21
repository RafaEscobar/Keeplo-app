import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AuthState()){
    //
  }
}