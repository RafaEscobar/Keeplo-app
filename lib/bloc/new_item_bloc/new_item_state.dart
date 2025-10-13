import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:keeplo/models/item.dart';

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
  final bool isEdition; //* Bandera para diferenciar formulario de edición
  final int itemId; //* Identificador númerico del item
  final Item? currentItem; //* Iten temporal

  const NewItemState({
    this.name = '',
    this.observations = '',
    this.image,
    this.amount = 1,
    this.vahulId = 0,
    this.status = NewItemStatus.initial,
    this.entityStatus = 1,
    this.messageError = '',
    this.formError = false,
    this.isEdition = false,
    this.itemId = -1,
    this.currentItem
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
    bool? isEdition,
    int? itemId,
    Item? currentItem
  }) => NewItemState(
    name: name ?? this.name,
    observations: observations ?? this.observations,
    image: image ?? this.image,
    vahulId: vahulId ?? this.vahulId,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    messageError: messageError ?? this.messageError,
    formError: formError ?? this.formError,
    entityStatus: entityStatus ?? this.entityStatus,
    isEdition: isEdition ?? this.isEdition,
    itemId: itemId ?? this.itemId,
    currentItem: currentItem ?? this.currentItem
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
    isEdition,
    itemId,
    currentItem
  ];
}