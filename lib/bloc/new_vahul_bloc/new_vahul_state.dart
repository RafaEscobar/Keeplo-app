import 'dart:io';

import 'package:equatable/equatable.dart';

enum NewVahulStatus {initial, loading, success, fail}
class NewVahulState extends Equatable{
  //* Info para creación de un vahul
  final String name;
  final String description;
  final String color;
  final File? image;
  final int userId;
  final NewVahulStatus status; //* Status de este State
  final String messageError; //* Mensaje de error para toast
  final bool formError;

  const NewVahulState({
    this.name = '',
    this.description = '',
    this.color = '',
    this.userId = 0,
    this.status = NewVahulStatus.initial,
    this.messageError = '',
    this.image,
    this.formError = false
  });

  NewVahulState copyWith({
    String? name,
    String? description,
    String? color,
    int? userId,
    NewVahulStatus? status,
    String? messageError,
    File? image,
    bool? formError,
  }) => NewVahulState(
    name: name ?? this.name,
    description: description ?? this.description,
    color: color ?? this.color,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    messageError: messageError ?? this.messageError,
    image: image ?? this.image,
    formError: formError ?? this.formError
  );

  @override
  List<Object?> get props => [name, description, color, userId, status, messageError, image, formError];
}