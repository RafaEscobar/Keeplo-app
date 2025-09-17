import 'dart:io';

import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';

abstract class NewVahulEvent {}

//* Evento para controlar valor de la variable -name- en el state
class VahulNameChange extends NewVahulEvent {
  final String name;
  VahulNameChange(this.name);
}

//* Evento para controlar valor de la variable -description- en el state
class VahulDescriptionChange extends NewVahulEvent {
  final String description;
  VahulDescriptionChange(this.description);
}

//* Evento para controlar valor de la variable -color- en el state
class VahulColorChange extends NewVahulEvent {
  final String color;
  VahulColorChange(this.color);
}

//* Evento para controlar valor de la variable -userId- en el state
class VahulUserIdChange extends NewVahulEvent {
  final int userId;
  VahulUserIdChange(this.userId);
}

//* Evento para controlar valor de la variable -messageError- en el state
class VahulMessageErrorChange extends NewVahulEvent {
  final String message;
  VahulMessageErrorChange(this.message);
}

//* Evento para controlar valor de la variable -image- en el state
class VahulImageChange extends NewVahulEvent {
  final File image;
  VahulImageChange(this.image);
}

//* Evento para controlar valor del status del state
class VahulStatusChange extends NewVahulEvent {
  final NewVahulStatus status;
  VahulStatusChange(this.status);
}

//* Evento para lanzar petición para crear un nuevo vahul
class SubmitVahulForm extends NewVahulEvent {}

//* Evento para limpiar state
class NewVahulClean extends NewVahulEvent {}