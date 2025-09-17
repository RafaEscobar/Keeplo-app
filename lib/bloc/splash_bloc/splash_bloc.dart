import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_event.dart';
import 'package:keeplo/bloc/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
  SplashBloc() : super(SplashState()) {
    on<UpdateDisplayedSplash>(_onUpdateDisplayedSplash);
  }

  //* Método para cambiar el valor de la variable -displayedSplash- en el state
  void _onUpdateDisplayedSplash(UpdateDisplayedSplash event, Emitter<SplashState> emit) {
    emit(state.copyWith(displayedSplash: event.displayedSplash));
  }

}