import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_event.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/utils/images.dart';

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
    on<SubmitItemForm>(_onSubmitItemForm);
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

  //* Método que realiza la petición para crear un nuevo vahul
  Future<void> _onSubmitItemForm(SubmitItemForm event, Emitter<NewItemState> emit) async {
    emit(state.copyWith(status: NewItemStatus.loading));

    try {
      if (state.image == null) {
        emit(state.copyWith(status: NewItemStatus.fail,));
        return;
      }
      final multipartFile = await Images.getMultipartFile(state.name, state.image!, state.image!.path);

      final formData = FormData.fromMap({
        'name': state.name,
        if(state.observations.isNotEmpty) 'observations': state.observations,
        'status': state.entityStatus,
        'amount': state.amount,
        'vahul_id': state.vahulId,
        'image': multipartFile,
      });

      final Response response = await ApiService.request(
        '/items',
        auth: Preferences.token,
        body: formData,
      );

      if (response.statusCode == 201) {
        emit(state.copyWith(status: NewItemStatus.success));
      } else {
        emit(state.copyWith(status: NewItemStatus.fail, messageError: response.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: NewItemStatus.fail, messageError: e.toString()));
    }
  }


}