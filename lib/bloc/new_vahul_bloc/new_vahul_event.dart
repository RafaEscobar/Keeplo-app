import 'dart:io';

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

class VahulImageChange extends NewVahulEvent {
  final File image;
  VahulImageChange(this.image);
}