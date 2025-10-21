import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class VahulBloc extends Bloc<VahulEvent, VahulState>{
  VahulBloc() : super(VahulState()){
    on<GetVahulesEvent>(_getVahules);
    on<SearchVahulEvent>(_onSearchVahulEvent);
    on<LoadMoreVahulesEvent>(_loadMoreVahules);
    on<VahulNewPageEvent>(_onVahulNewPageEvent);
    on<VahulOrderChange>(_onVahulOrderChange);
    on<VahulChangeStatus>(_onVahulChangeStatus);
    on<VahulDeleteEvent>(_onVahulDeleteEvent);
  }

  //* Método para obtener el listado de vahules
  Future<void> _getVahules(GetVahulesEvent event, Emitter<VahulState> emit) async {
    try {
      emit(state.copyWith(status: VahulStatus.loading));
      String order = state.isAscOrder ? 'asc' : 'desc';
      final respose = await ApiService.request("/vahuls?limit=24&order=$order", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Vahul> list = (respose.data['data'] as List).map((vahul) => Vahul.fromJson(vahul)).toList();
        emit(state.copyWith(
          status: VahulStatus.success,
          vahules: List.from(list),
          initialVahules: List.from(list),
          hasMore: respose.data['meta']['links']['next'] != null
        ));
      } else {
        emit(state.copyWith(status: VahulStatus.failure, errorMessage: respose.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

  //* Método para obtener la siguiente page de vahules y fucionarla con la lista actual
  Future<void> _loadMoreVahules(LoadMoreVahulesEvent event, Emitter<VahulState> emit) async {
    try {
      if (state.loadingMore) return;
      if (event.newPage <= state.page) return;
      emit(state.copyWith(loadingMore: true));
      String order = state.isAscOrder ? 'asc' : 'desc';
      final respose = await ApiService.request("/vahuls?limit=24&&order=$order&page=${event.newPage}", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Vahul> list = state.vahules;
        list.addAll((respose.data['data'] as List).map((vahul) => Vahul.fromJson(vahul)).toList());
        emit(state.copyWith(
          vahules: List.from(list),
          initialVahules: List.from(list),
          hasMore: respose.data['meta']['links']['next'] != null,
          page: event.newPage,
          loadingMore: false
        ));
      } else {
        emit(state.copyWith(status: VahulStatus.failure, errorMessage: respose.data['message'], loadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure, loadingMore: false));
      throw e.toString();
    }
  }

  //* Método para buscar vahules por nombre (funcionamiento local)
  Future<void> _onSearchVahulEvent(SearchVahulEvent event, Emitter<VahulState> emit) async {
    try {
      if (event.text.isNotEmpty) {
        emit(state.copyWith(status: VahulStatus.loading));
        final respose = await ApiService.request("/vahuls?search=${event.text.toLowerCase()}", auth: Preferences.token);
        if (respose.statusCode == 200) {
          List<Vahul> list = (respose.data['data'] as List).map((vahul) => Vahul.fromJson(vahul)).toList();
          emit(state.copyWith(
            vahules: list,
            status: VahulStatus.searching
          ));
        } else {
          emit(state.copyWith(
            vahules: state.initialVahules,
            status: VahulStatus.failure,
            errorMessage: "Algo salió mal en la búsqueda."
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

  //* Método para eliminar un vahul
  Future<void> _onVahulDeleteEvent(VahulDeleteEvent event, Emitter<VahulState> emit) async {
    try {
      emit(state.copyWith(status: VahulStatus.removing));
      final response = await ApiService.request('/vahuls/${event.vahulId}', deleteBody: {}, auth: Preferences.token);
      if (response.statusCode == 204) {
        emit(state.copyWith(status: VahulStatus.vahulRemoved));
      } else {
        emit(state.copyWith(status: VahulStatus.failure, errorMessage: "${response.data["message"]}"));
      }
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

  //* Método para cambiar de page
  void _onVahulNewPageEvent(VahulNewPageEvent event, Emitter<VahulState> emit) {
    try {
      emit(state.copyWith(page: event.newPage));
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para cambiar dínamicamente el tipo de ordenamiento
  void _onVahulOrderChange(VahulOrderChange event, Emitter<VahulState> emit){
    try {
      emit(state.copyWith(isAscOrder: !state.isAscOrder));
    } catch (e) {
      throw e.toString();
    }
  }

  //* Método para cambiar dínamicamente el tipo de ordenamiento
  void _onVahulChangeStatus(VahulChangeStatus event, Emitter<VahulState> emit){
    try {
      emit(state.copyWith(status: event.status));
    } catch (e) {
      throw e.toString();
    }
  }
}