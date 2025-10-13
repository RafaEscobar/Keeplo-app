import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/utils/images.dart';

class NewVahulBloc extends Bloc<NewVahulEvent, NewVahulState>{
  NewVahulBloc() : super(NewVahulState()) {
    on<VahulNameChange>(_onVahulNameChange);
    on<VahulDescriptionChange>(_onVahulDescriptionChange);
    on<VahulImageChange>(_onVahulImageChange);
    on<SubmitVahulForm>(_onSubmitVahulForm);
    on<VahulUserIdChange>(_onVahulUserIdChange);
    on<VahulStatusChange>(_onVahulStatusChange);
    on<VahulMessageErrorChange>(_onVahulMessageErrorChange);
    on<NewVahulClean>(_onNewVahulClean);
    on<VahulFormErrorChange>(_onVahulFormErrorChange);
    on<SubmitVahulUpdateForm>(_onSubmitVahulUpdateForm);
    on<VahulIsEditionChange>(_onVahulIsEditionChange);
  }

  //* Método que realiza la petición para crear un nuevo vahul
  Future<void> _onSubmitVahulForm(SubmitVahulForm event, Emitter<NewVahulState> emit) async {
    emit(state.copyWith(status: NewVahulStatus.loading));

    try {
      if (state.image == null) {
        emit(state.copyWith(status: NewVahulStatus.fail,));
        return;
      }
      final multipartFile = await Images.getMultipartFile(state.name, state.image!, state.image!.path);

      final formData = FormData.fromMap({
        'name': state.name,
        if(state.description.isNotEmpty) 'description': state.description,
        'user_id': state.userId,
        'image': multipartFile,
      });

      final Response response = await ApiService.request(
        '/vahuls',
        auth: Preferences.token,
        body: formData,
      );

      if (response.statusCode == 201) {
        emit(state.copyWith(status: NewVahulStatus.success));
      } else {
        emit(state.copyWith(status: NewVahulStatus.fail, messageError: response.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: NewVahulStatus.fail, messageError: e.toString()));
    }
  }

  //* Método que realiza la petición para crear un nuevo vahul
  Future<void> _onSubmitVahulUpdateForm(SubmitVahulUpdateForm event, Emitter<NewVahulState> emit) async {
    emit(state.copyWith(status: NewVahulStatus.loading));

    try {
      MultipartFile multipartFile = MultipartFile.fromString('value');
      if (state.image != null) {
        if (state.image != null && state.image!.path.isNotEmpty) {
          multipartFile = await Images.getMultipartFile(state.name, state.image!, state.image!.path);
        }
      }

      final formData = FormData.fromMap({
        'name': state.name,
        if(state.description.isNotEmpty) 'description': state.description,
        'user_id': state.userId,
        if (state.image != null && state.image!.path.isNotEmpty) 'image': multipartFile,
        '_method': "PATCH"
      });

      final Response response = await ApiService.request(
        '/vahuls/${event.vahulId}',
        auth: Preferences.token,
        body: formData,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: NewVahulStatus.success));
      } else {
        emit(state.copyWith(status: NewVahulStatus.fail, messageError: response.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: NewVahulStatus.fail, messageError: e.toString()));
    }
  }

  //* Método para cambiar valor de la variable -name- del state
  void _onVahulNameChange(VahulNameChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(name: event.name));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -description- del state
  void _onVahulDescriptionChange(VahulDescriptionChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(description: event.description));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -userId- del state
  void _onVahulUserIdChange(VahulUserIdChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(userId: event.userId));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -image- del state
  void _onVahulImageChange(VahulImageChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(image: event.image));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar valor de la variable -messageError- del state
  void _onVahulMessageErrorChange(VahulMessageErrorChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(messageError: event.message));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el valor de la variable -formError- del state
  void _onVahulFormErrorChange(VahulFormErrorChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(formError: event.formError));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el -status- del state
  void _onVahulStatusChange(VahulStatusChange event, Emitter<NewVahulState> emit){
    try {
      emit(state.copyWith(status: event.status));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para cambiar el -status- del state
  void _onVahulIsEditionChange(VahulIsEditionChange event, Emitter<NewVahulState> emit){
    try {
      emit(state.copyWith(isEdition: event.isEdition));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //* Método para limpiar nuestro state
  void _onNewVahulClean(NewVahulClean event, Emitter<NewVahulState> emit) {
    emit(state.copyWith(
      name: '',
      description: '',
      image: File(''),
      userId: 0,
      status: NewVahulStatus.initial,
      messageError: '',
      formError: false,
      isEdition: false
    ));
  }
}