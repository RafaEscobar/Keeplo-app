import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_event.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState>{
  NewItemBloc() : super(NewItemState()){
    on<NewItemClean>(_onNewItemClean);
    on<ItemNameChange>(_onVahulNameChange);
    on<ItemObservationsChange>(_onItemObservationsChange);
    on<ItemVahulIdChange>(_onItemVahulIdChange);
    on<ItemImageChange>(_onItemImageChange);
    on<ItemMessageErrorChange>(_onVahulMessageErrorChange);
    on<ItemFormErrorChange>(_onItemFormErrorChange);
    on<ItemStatusChange>(_onItemStatusChange);
    on<StatusEntityChange>(_onStatusEntityChange);
    on<ItemAmountChange>(_onItemAmountChange);
  }

  //* Método para cambiar valor de la variable -name- del state
  void _onVahulNameChange(ItemNameChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(name: event.name));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -description- del state
  void _onItemObservationsChange(ItemObservationsChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(observations: event.observations));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -userId- del state
  void _onItemVahulIdChange(ItemVahulIdChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(vahulId: event.vahulId));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onItemAmountChange(ItemAmountChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(amount: event.amount.toInt()));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -image- del state
  void _onItemImageChange(ItemImageChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(image: event.image));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -messageError- del state
  void _onVahulMessageErrorChange(ItemMessageErrorChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(messageError: event.message));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el valor de la variable -formError- del state
  void _onItemFormErrorChange(ItemFormErrorChange event, Emitter<NewItemState> emit) {
    try {
      emit(state.copyWith(formError: event.formError));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el -status- del state
  void _onItemStatusChange(ItemStatusChange event, Emitter<NewItemState> emit){
    try {
      emit(state.copyWith(status: event.status));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el -status- del state
  void _onStatusEntityChange(StatusEntityChange event, Emitter<NewItemState> emit){
    try {
      emit(state.copyWith(entityStatus: event.newStatus));
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  //* Método para limpiar nuestro state
  void _onNewItemClean(NewItemClean event, Emitter<NewItemState> emit) {
    emit(state.copyWith(
      name: '',
      observations: '',
      image: File(''),
      vahulId: 0,
      amount: 1,
      status: NewItemStatus.initial,
      messageError: '',
      formError: false
    ));
  }


}