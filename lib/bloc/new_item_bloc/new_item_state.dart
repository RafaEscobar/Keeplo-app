import 'dart:io';
import 'package:equatable/equatable.dart';

enum NewItemStatus {initial, loading, success, fail}

class NewItemState extends Equatable{
  //* Info para creación de un item
  final String name;
  final String observations;
  final File? image;
  final int vahulId;
  final NewItemStatus status; //* Status de este State
  final String messageError; //* Mensaje de error para toast
  final bool formError;

  const NewItemState({
    this.name = '',
    this.observations = '',
    this.image,
    this.vahulId = 0,
    this.status = NewItemStatus.initial,
    this.messageError = '',
    this.formError = false
  });

  NewItemState copyWith({
    String? name,
    String? observations,
    File? image,
    int? vahulId,
    NewItemStatus? status,
    String? messageError,
    bool? formError,
  }) => NewItemState(
    name: name ?? this.name,
    observations: observations ?? this.observations,
    image: image ?? this.image,
    vahulId: vahulId ?? this.vahulId,
    status: status ?? this.status,
    messageError: messageError ?? this.messageError,
    formError: formError ?? this.formError
  );

  @override
  List<Object?> get props => [];
}