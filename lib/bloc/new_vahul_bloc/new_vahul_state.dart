import 'dart:io';

import 'package:equatable/equatable.dart';

class NewVahulState extends Equatable{
  final String name;
  final String description;
  final String color;
  final File? image;

  const NewVahulState({
    this.name = '',
    this.description = '',
    this.color = '',
    this.image
  });

  NewVahulState copyWith({
    String? name,
    String? description,
    String? color,
    File? image
  }) => NewVahulState(
    name: name ?? this.name,
    description: description ?? this.description,
    color: color ?? this.color,
    image: image ?? this.image
  );

  @override
  List<Object?> get props => [name, description, color, image];
}