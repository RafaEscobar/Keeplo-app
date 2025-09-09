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
    on<OrderListEvent>(_onOrderListEvent);
    on<LoadMoreVahulesEvent>(_loadMoreVahules);
    on<VahulNewPageEvent>(_onVahulNewPageEvent);
  }

  Future<void> _getVahules(GetVahulesEvent event, Emitter<VahulState> emit) async {
    try {
      emit(state.copyWith(status: VahulStatus.loading));
      final respose = await ApiService.request("/vahuls?limit=10&page=${state.page}", auth: Preferences.token);
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

  Future<void> _loadMoreVahules(LoadMoreVahulesEvent event, Emitter<VahulState> emit) async {
    try {
      final respose = await ApiService.request("/vahuls?limit=12&page=${state.page}", auth: Preferences.token);
      if (respose.statusCode == 200) {
        List<Vahul> list = state.vahules;
        list.addAll((respose.data['data'] as List).map((vahul) => Vahul.fromJson(vahul)).toList());
        emit(state.copyWith(
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

  void _onSearchVahulEvent(SearchVahulEvent event, Emitter<VahulState> emit){
    try {
      emit(state.copyWith(
        vahules: (event.text.isEmpty) ?
          state.initialVahules :
          state.vahules.where((vahul) => vahul.name.toLowerCase().contains(event.text.toLowerCase()),).toList(),
        status: VahulStatus.searching
      ));
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

  void _onOrderListEvent(OrderListEvent event, Emitter<VahulState> emit) {
    try {
      emit(state.copyWith(
        vahules: state.vahules.reversed.toList(),
        initialVahules: state.initialVahules.reversed.toList(),
        hasOrder: !state.hasOrder
      ));
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

  void _onVahulNewPageEvent(VahulNewPageEvent event, Emitter<VahulState> emit) {
    try {
      emit(state.copyWith(page: event.newPage));
    } catch (e) {
      throw e.toString();
    }
  }
}