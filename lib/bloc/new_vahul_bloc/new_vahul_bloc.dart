import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/utils/hexa_color.dart';
import 'package:path/path.dart' as p;

class NewVahulBloc extends Bloc<NewVahulEvent, NewVahulState>{
  NewVahulBloc() : super(NewVahulState(color: HexaColor.getCode(Colors.blue))) {
    on<VahulNameChange>(_onVahulNameChange);
    on<VahulDescriptionChange>(_onVahulDescriptionChange);
    on<VahulColorChange>(_onVahulColorChange);
    on<VahulImageChange>(_onVahulImageChange);
    on<SubmitVahulForm>(_onSubmitVahulForm);
    on<VahulUserIdChange>(_onVahulUserIdChange);
    on<VahulStatusChange>(_onVahulStatusChange);
    on<VahulMessageErrorChange>(_onVahulMessageErrorChange);
    on<NewVahulClean>(_onNewVahulClean);
    on<VahulFormErrorChange>(_onVahulFormErrorChange);
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

  //* Método para cambiar valor de la variable -color- del state
  void _onVahulColorChange(VahulColorChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(color: event.color));
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

  //* Método para limpiar nuestro state
  void _onNewVahulClean(NewVahulClean event, Emitter<NewVahulState> emit) {
    emit(state.copyWith(
      name: '',
      description: '',
      color: HexaColor.getCode(Colors.blue),
      image: File(''),
      userId: 0,
      status: NewVahulStatus.initial,
      messageError: '',
      formError: false
    ));
  }

  //* Método que realiza la petición para crear un nuevo vahul
  Future<void> _onSubmitVahulForm(SubmitVahulForm event, Emitter<NewVahulState> emit) async {
    emit(state.copyWith(status: NewVahulStatus.loading));

    try {
      if (state.image == null) {
        emit(state.copyWith(status: NewVahulStatus.fail,));
        return;
      }
      final multipartFile = await _getMultipartFile(state.color, state.name, state.image!);

      final formData = FormData.fromMap({
        'name': state.name,
        if(state.description.isNotEmpty) 'description': state.description,
        if(state.color.isNotEmpty) 'color': state.color,
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

  //* Método que tratar la imagen y asignar un nombre limpio
  Future<MultipartFile> _getMultipartFile(String color, String name, File image) async {
    final safeColor = color.replaceAll('#', ''); //? Obtenemos el valor númerico del color
    final safeName = name.replaceAll(RegExp(r'[^A-Za-z0-9_\-]'), '_'); //? Limpiamos el nombre de nuestro vahul

    final ext = p.extension(image.path); //? Obtenemos la extensión de nuestra imagen cargada
    final filename = '${safeName}_${safeColor}_image$ext'; //? Generamos el nombre con: nombreLimpio_colorNúmerico_image_extension

    // Generamos el MultipartFile a partir de la imagen y el nombre construido
    final file = await MultipartFile.fromFile(
      state.image!.path,
      filename: filename,
    );

    return file; // Retornamos la -construcción segura- de la imagen
  }

}