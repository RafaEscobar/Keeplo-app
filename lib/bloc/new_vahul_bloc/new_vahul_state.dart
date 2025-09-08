import 'dart:io';

import 'package:equatable/equatable.dart';

enum NewVahulStatus {initial, loading, success, fail}
class NewVahulState extends Equatable{
  final String name;
  final String description;
  final String color;
  final File? image;
  final int userId;
  final NewVahulStatus status;

  const NewVahulState({
    this.name = '',
    this.description = '',
    this.color = '',
    this.userId = 0,
    this.status = NewVahulStatus.initial,
    this.image
  });

  NewVahulState copyWith({
    String? name,
    String? description,
    String? color,
    int? userId,
    NewVahulStatus? status,
    File? image
  }) => NewVahulState(
    name: name ?? this.name,
    description: description ?? this.description,
    color: color ?? this.color,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    image: image ?? this.image
  );

  @override
  List<Object?> get props => [name, description, color, userId, status, image];
}