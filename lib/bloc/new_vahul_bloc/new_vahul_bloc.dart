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

  void _onVahulUserIdChange(VahulUserIdChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(userId: event.userId));
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

  void _onVahulMessageErrorChange(VahulMessageErrorChange event, Emitter<NewVahulState> emit) {
    try {
      emit(state.copyWith(messageError: event.message));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onVahulStatusChange(VahulStatusChange event, Emitter<NewVahulState> emit){
    try {
      emit(state.copyWith(status: event.status));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onNewVahulClean(NewVahulClean event, Emitter<NewVahulState> emit) {
    emit(state.copyWith(
      name: '',
      description: '',
      color: '',
      image: File(''),
      userId: 0,
      status: NewVahulStatus.initial,
      messageError: ''
    ));
  }

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
        'description': state.description,
        'color': state.color,
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

  Future<MultipartFile> _getMultipartFile(String color, String name, File image) async {
    final safeColor = color.replaceAll('#', '');
    final safeName = name.replaceAll(RegExp(r'[^A-Za-z0-9_\-]'), '_');

    final ext = p.extension(image.path);
    final filename = '${safeName}_${safeColor}_image$ext';

    final file = await MultipartFile.fromFile(
      state.image!.path,
      filename: filename,
    );

    return file;
  }

}