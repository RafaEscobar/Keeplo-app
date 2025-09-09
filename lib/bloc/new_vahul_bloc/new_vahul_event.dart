import 'dart:io';

import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';

abstract class NewVahulEvent {}

class VahulNameChange extends NewVahulEvent {
  final String name;
  VahulNameChange(this.name);
}

class VahulDescriptionChange extends NewVahulEvent {
  final String description;
  VahulDescriptionChange(this.description);
}

class VahulColorChange extends NewVahulEvent {
  final String color;
  VahulColorChange(this.color);
}

class VahulUserIdChange extends NewVahulEvent {
  final int userId;
  VahulUserIdChange(this.userId);
}

class VahulMessageErrorChange extends NewVahulEvent {
  final String message;
  VahulMessageErrorChange(this.message);
}

class VahulStatusChange extends NewVahulEvent {
  final NewVahulStatus status;
  VahulStatusChange(this.status);
}

class VahulImageChange extends NewVahulEvent {
  final File image;
  VahulImageChange(this.image);
}

class SubmitVahulForm extends NewVahulEvent {}