import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_event.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState>{
  NewItemBloc() : super(NewItemState()){
    on<NewItemClean>(_onNewItemClean);
  }

  //* Método para limpiar nuestro state
  void _onNewItemClean(NewItemClean event, Emitter<NewItemState> emit) {
    emit(state.copyWith(
      name: '',
      observations: '',
      image: File(''),
      vahulId: 0,
      status: NewItemStatus.initial,
      messageError: '',
      formError: false
    ));
  }


}