import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState>{
  ItemBloc() : super(ItemState()){
    on<GetItemsEvent>(_getItems);
    on<SearchItemEvent>(_onSearchVahulEvent);
    on<LoadMoreItemsEvent>(_loadMoreVahules);
    on<ItemNewPageEvent>(_onVahulNewPageEvent);
    on<ClearItemPage>(_onClearItemPage);
    on<ItemOrderChange>(_onVahulOrderChange);
    on<ItemChangeStatus>(_onItemChangeStatus);
    on<SetVahulIdEvent>(_onSetVahulIdEvent);
    on<ItemDeleteEvent>(_onItemDeleteEvent);
  }

  //* Método para obtener el listado de vahules
  Future<void> _getItems(GetItemsEvent event, Emitter<ItemState> emit) async {
    try {
      emit(state.copyWith(status: ItemStatus.loading));
      String order = state.isAscOrder ? 'asc' : 'desc';
      final respose = await ApiService.request("/items?limit=24&order=$order&vahul_id=${state.vahulId}", auth: Preferences.token);
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
      final respose = await ApiService.request("/items?limit=24&order=$order&page=${event.newPage}&vahul_id=${state.vahulId}", auth: Preferences.token);
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

  //* Método para realizar carga de eliminación de item
  Future<void> _onItemDeleteEvent(ItemDeleteEvent event, Emitter<ItemState> emit) async {
    try {
      emit(state.copyWith(status: ItemStatus.removing));
      final response = await ApiService.request("/items/${event.itemId}", auth: Preferences.token, deleteBody: {});
      if (response.statusCode == 204) {
        emit(state.copyWith(status: ItemStatus.itemRemoved));
      } else {
        emit(state.copyWith(status: ItemStatus.failure, errorMessage: "${response.data["message"]}"));
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para buscar vahules por nombre (funcionamiento local)
  Future<void> _onSearchVahulEvent(SearchItemEvent event, Emitter<ItemState> emit) async {
    try {
      emit(state.copyWith(status: ItemStatus.loading));
      final respose = await ApiService.request("/items?vahul_id=${state.vahulId}&search=${event.word.toLowerCase()}", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Item> list = (respose.data['data'] as List).map((vahul) => Item.fromJson(vahul)).toList();
        emit(state.copyWith(
          items: list,
          status: ItemStatus.searching
        ));
      } else {
        emit(state.copyWith(
          items: state.initialItems,
          status: ItemStatus.failure,
          errorMessage: "Algo salió mal en la búsqueda."
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: ItemStatus.failure));
      throw e.toString();
    }
  }

  //* Método para cambiar de -page-
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

  //* Método para cambiar valor del -status- del state
  void _onItemChangeStatus(ItemChangeStatus event, Emitter<ItemState> emit) {
    try {
      emit(state.copyWith(status: event.status));
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para asignar un valor al -vahulId-
  void _onSetVahulIdEvent(SetVahulIdEvent event, Emitter<ItemState> emit) {
    try {
      emit(state.copyWith(vahulId: event.vahuldId));
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para limpiar el valor del page del state
  void _onClearItemPage(ClearItemPage event, Emitter<ItemState> emit) {
    try {
      emit(state.copyWith(page: 1));
    } catch (e) {
      throw e.toString();
    }
  }
}