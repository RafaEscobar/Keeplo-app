// Clase abstracta base
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

class ItemOrderChange extends ItemEvent {}