import 'dart:io';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/models/vahul.dart';

//* Clase base abstracta
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

//* Evento para controlar valor de la variable -formError- en el state
class VahulFormErrorChange extends NewVahulEvent {
  final bool formError;
  VahulFormErrorChange(this.formError);
}

//* Evento para controlar valor de la variable -isEdition- en el state
class VahulIsEditionChange extends NewVahulEvent {
  final bool isEdition;
  VahulIsEditionChange(this.isEdition);
}

//* Evento para lanzar petición para crear un nuevo vahul
class SubmitVahulForm extends NewVahulEvent {}

//* Evento para lanzar petición para actualizar un nuevo vahul
class SubmitVahulUpdateForm extends NewVahulEvent {
  final int vahulId;
  SubmitVahulUpdateForm(this.vahulId);
}

//* Método para setear vahul actual
class SetCurrentVahulEvent extends NewVahulEvent {
  final Vahul currentVahul;
  SetCurrentVahulEvent(this.currentVahul);
}

//* Evento para limpiar state
class NewVahulClean extends NewVahulEvent {}

//* Evento para limpiar currentVahul
class CurrentVahulClean extends NewVahulEvent {}
