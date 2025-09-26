// Clase abstracta base
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/models/vahul.dart';

abstract class ItemEvent {}

class GetItemEvent extends ItemEvent{}

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

class SetItemEvent extends ItemEvent {
  final Vahul vahul;
  SetItemEvent(this.vahul);
}

class ItemChangeStatus extends ItemEvent {
  final ItemStatus status;
  ItemChangeStatus(this.status);
}

class ItemOrderChange extends ItemEvent {}

