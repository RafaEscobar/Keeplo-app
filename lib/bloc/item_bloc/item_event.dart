import 'package:keeplo/bloc/item_bloc/item_state.dart';

//* Clase abstracta base
abstract class ItemEvent {}

//* Evento para obtener el listado de items
class GetItemsEvent extends ItemEvent{}

//* Evento para buscar un item por su nombre
class SearchItemEvent extends ItemEvent{
  final String word;
  SearchItemEvent(this.word);
}

//* Evento para cargar más items -paginación-
class LoadMoreItemsEvent extends ItemEvent{
  final int newPage;
  LoadMoreItemsEvent(this.newPage);
}

//* Evento para setear la nueva page -paginación-
class ItemNewPageEvent extends ItemEvent{
  final int newPage;
  ItemNewPageEvent(this.newPage);
}

//* Evento para cambiar el valor de la variable -status-
class ItemChangeStatus extends ItemEvent {
  final ItemStatus status;
  ItemChangeStatus(this.status);
}

//* Evento para setear el id del vahul
class SetVahulIdEvent extends ItemEvent {
  final int vahuldId;
  SetVahulIdEvent(this.vahuldId);
}

//* Evento para lanzar petición para eliminar item
class ItemDeleteEvent extends ItemEvent {
  final int itemId;
  ItemDeleteEvent(this.itemId);
}

//* Evento para cambiar dínamicamente el valor del ordenamiento
class ItemOrderChange extends ItemEvent {}