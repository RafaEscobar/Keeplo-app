import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/splash_bloc/splash_event.dart';
import 'package:keeplo/bloc/splash_bloc/splash_state.dart';

class AppBloc extends Bloc<AppEvent, AppState>{
  AppBloc() : super(AppState()) {
    on<UpdateIsLogged>(_onUpdateIsLogged);
    on<UpdateDisplayedSplash>(_onUpdateDisplayedSplash);
  }

  void _onUpdateIsLogged(UpdateIsLogged event, Emitter<AppState> emit) {
    emit(state.copyWith(
      isLogged: event.isLogged,
    ));
  }

  void _onUpdateDisplayedSplash(UpdateDisplayedSplash event, Emitter<AppState> emit) {
    emit(state.copyWith(
      displayedSplash: event.displayedSplash
    ));
  }

}