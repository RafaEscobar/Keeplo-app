import 'dart:io';
import 'package:equatable/equatable.dart';

enum NewItemStatus {initial, loading, success, fail}

class NewItemState extends Equatable{
  //* Info para creación de un item
  final String name;
  final String observations;
  final File? image;
  final int vahulId;
  final int amount;
  final int entityStatus;
  final NewItemStatus status; //* Status de este State
  final String messageError; //* Mensaje de error para toast
  final bool formError; //* Bandera para lanzar error de validación

  const NewItemState({
    this.name = '',
    this.observations = '',
    this.image,
    this.amount = 1,
    this.vahulId = 0,
    this.status = NewItemStatus.initial,
    this.entityStatus = 1,
    this.messageError = '',
    this.formError = false
  });

  NewItemState copyWith({
    String? name,
    String? observations,
    File? image,
    int? vahulId,
    int? amount,
    NewItemStatus? status,
    int? entityStatus,
    String? messageError,
    bool? formError,
  }) => NewItemState(
    name: name ?? this.name,
    observations: observations ?? this.observations,
    image: image ?? this.image,
    vahulId: vahulId ?? this.vahulId,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    messageError: messageError ?? this.messageError,
    formError: formError ?? this.formError,
    entityStatus: entityStatus ?? this.entityStatus
  );

  @override
  List<Object?> get props => [
    name,
    observations,
    image,
    amount,
    vahulId,
    status,
    entityStatus,
    messageError,
    formError,
  ];
}