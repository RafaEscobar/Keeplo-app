// Clase abstracta base
import 'package:keeplo/bloc/item_bloc/item_state.dart';

abstract class ItemEvent {}

class GetItemsEvent extends ItemEvent{}

class SearchItemEvent extends ItemEvent{
  final String word;
  SearchItemEvent(this.word);
}

class LoadMoreItemsEvent extends ItemEvent{
  final int newPage;
  LoadMoreItemsEvent(this.newPage);
}

class ItemNewPageEvent extends ItemEvent{
  final int newPage;
  ItemNewPageEvent(this.newPage);
}

class ItemChangeStatus extends ItemEvent {
  final ItemStatus status;
  ItemChangeStatus(this.status);
}

//* Método para setear el id del vahul
class SetVahulIdEvent extends ItemEvent {
  final int vahuldId;
  SetVahulIdEvent(this.vahuldId);
}

//* Método para lanzar petición para eliminar item
class ItemDeleteEvent extends ItemEvent {
  final int itemId;
  ItemDeleteEvent(this.itemId);
}

class ItemOrderChange extends ItemEvent {}

