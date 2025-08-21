import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_event.dart';
import 'package:keeplo/bloc/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
  SplashBloc() : super(SplashState()) {
    on<UpdateIsLogged>(_onUpdateIsLogged);
    on<UpdateDisplayedSplash>(_onUpdateDisplayedSplash);
  }

  void _onUpdateIsLogged(UpdateIsLogged event, Emitter<SplashState> emit) {
    emit(state.copyWith(
      isLogged: event.isLogged,
    ));
  }

  void _onUpdateDisplayedSplash(UpdateDisplayedSplash event, Emitter<SplashState> emit) {
    emit(state.copyWith(
      displayedSplash: event.displayedSplash
    ));
  }

}