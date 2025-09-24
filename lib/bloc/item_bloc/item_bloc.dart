import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState>{
  ItemBloc() : super(ItemState()){
    on<GetItemEvent>(_getVahules);
    on<SearchItemEvent>(_onSearchVahulEvent);
    on<LoadMoreItemsEvent>(_loadMoreVahules);
    on<ItemNewPageEvent>(_onVahulNewPageEvent);
    on<ItemOrderChange>(_onVahulOrderChange);
    on<SetItemEvent>(_onSetItemEvent);
  }

    //* Método para obtener el listado de vahules
  Future<void> _getVahules(GetItemEvent event, Emitter<ItemState> emit) async {
    try {
      emit(state.copyWith(status: ItemStatus.initial));
      String order = state.isAscOrder ? 'asc' : 'desc';
      final respose = await ApiService.request("/items?limit=24&order=$order&vahul_id=${state.currentVahul!.id}", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Item> list = (respose.data['data'] as List).map((vahul) => Item.fromJson(vahul)).toList();
        emit(state.copyWith(
          status: ItemStatus.success,
          items: List.from(list),
          initialItems: List.from(list),
          hasMore: respose.data['meta']['links']['next'] != null
        ));
      } else {
        emit(state.copyWith(status: ItemStatus.failure, errorMessage: respose.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: ItemStatus.failure));
      throw e.toString();
    }
  }

  //* Método para obtener la siguiente page de vahules y fucionarla con la lista actual
  Future<void> _loadMoreVahules(LoadMoreItemsEvent event, Emitter<ItemState> emit) async {
    try {
      if (state.loadingMore) return;
      if (event.newPage <= state.page) return;
      emit(state.copyWith(loadingMore: true));
      String order = state.isAscOrder ? 'asc' : 'desc';
      final respose = await ApiService.request("/items?limit=24&&order=$order&page=${event.newPage}&vahul_id=${state.currentVahul!.id}", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Item> list = state.items;
        list.addAll((respose.data['data'] as List).map((vahul) => Item.fromJson(vahul)).toList());
        emit(state.copyWith(
          items: List.from(list),
          initialItems: List.from(list),
          hasMore: respose.data['meta']['links']['next'] != null,
          page: event.newPage,
          loadingMore: false
        ));
      } else {
        emit(state.copyWith(status: ItemStatus.failure, errorMessage: respose.data['message'], loadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(status: ItemStatus.failure, loadingMore: false));
      throw e.toString();
    }
  }

  //* Método para buscar vahules por nombre (funcionamiento local)
  void _onSearchVahulEvent(SearchItemEvent event, Emitter<ItemState> emit){
    try {
      emit(state.copyWith(
        items: (event.word.isEmpty) ?
          state.initialItems :
          state.items.where((vahul) => vahul.name.toLowerCase().contains(event.word.toLowerCase()),).toList(),
        status: ItemStatus.searching
      ));
    } catch (e) {
      emit(state.copyWith(status: ItemStatus.failure));
      throw e.toString();
    }
  }

  //* Método para cambiar de page
  void _onVahulNewPageEvent(ItemNewPageEvent event, Emitter<ItemState> emit) {
    try {
      emit(state.copyWith(page: event.newPage));
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para cambiar dínamicamente el tipo de ordenamiento
  void _onVahulOrderChange(ItemOrderChange event, Emitter<ItemState> emit){
    try {
      emit(state.copyWith(isAscOrder: !state.isAscOrder));
    } catch (e) {
      throw e.toString();
    }
  }

  void _onSetItemEvent(SetItemEvent event, Emitter<ItemState> emit) {
    try {
      emit(state.copyWith(currentVahul: event.vahul));
    } catch (e) {
      throw e.toString();
    }
  }

}