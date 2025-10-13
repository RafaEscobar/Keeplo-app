import 'dart:io';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';
import 'package:keeplo/models/item.dart';

//* Clase base abstracta
abstract class NewItemEvent {}

//* Evento para controlar valor de la variable -name- en el state
class ItemNameChange extends NewItemEvent {
  final String name;
  ItemNameChange(this.name);
}

//* Evento para controlar valor de la variable -observations- en el state
class ItemObservationsChange extends NewItemEvent {
  final String observations;
  ItemObservationsChange(this.observations);
}

//* Evento para controlar valor de la variable -amount- en el state
class ItemAmountChange extends NewItemEvent {
  final int amount;
  ItemAmountChange(this.amount);
}

//* Evento para controlar valor de la variable -vahulId- en el state
class ItemVahulIdChange extends NewItemEvent {
  final int vahulId;
  ItemVahulIdChange(this.vahulId);
}

//* Evento para controlar valor de la variable -messageError- en el state
class ItemMessageErrorChange extends NewItemEvent {
  final String message;
  ItemMessageErrorChange(this.message);
}

//* Evento para controlar valor de la variable -image- en el state
class ItemImageChange extends NewItemEvent {
  final File image;
  ItemImageChange(this.image);
}

//* Evento para controlar valor del -status- de la entidad item
class StatusEntityChange extends NewItemEvent {
  final int newStatus;
  StatusEntityChange(this.newStatus);
}

//* Evento para controlar valor del status del state
class ItemStatusChange extends NewItemEvent {
  final NewItemStatus status;
  ItemStatusChange(this.status);
}

//* Evento para controlar valor de la variable -formError- en el state
class ItemFormErrorChange extends NewItemEvent {
  final bool formError;
  ItemFormErrorChange(this.formError);
}

class ItemIsEditionChange extends NewItemEvent {
  final bool isEdition;
  ItemIsEditionChange(this.isEdition);
}

class SubmitItemUpdate extends NewItemEvent {
  final int itemId;
  SubmitItemUpdate(this.itemId);
}

class SetCurrentItem extends NewItemEvent {
  final Item item;
  SetCurrentItem(this.item);
}

//* Evento para limpiar el state
class NewItemClean extends NewItemEvent {}

//* Evento para lanzar petición para crear un nuevo vahul
class SubmitItemForm extends NewItemEvent {}