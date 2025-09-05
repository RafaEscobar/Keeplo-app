import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';

class NewVahulBloc extends Bloc<NewVahulEvent, NewVahulState>{
  NewVahulBloc() : super(NewVahulState()) {
    on<VahulNameChange>(_onVahulNameChange);
    on<VahulDescriptionChange>(_onVahulDescriptionChange);
    on<VahulColorChange>(_onVahulColorChange);
    on<VahulImageChange>(_onVahulImageChange);
  }

  void _onVahulNameChange(VahulNameChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(name: event.name));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onVahulDescriptionChange(VahulDescriptionChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(description: event.description));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onVahulColorChange(VahulColorChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(color: event.color));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onVahulImageChange(VahulImageChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(image: event.image));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}