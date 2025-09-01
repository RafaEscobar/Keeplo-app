import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/services/api_service.dart';
import 'package:keeplo/services/preferences.dart';

class VahulBloc extends Bloc<VahulEvent, VahulState>{
  VahulBloc() : super(VahulState()){
    on<GetVahulesEvent>(_getVahules);
  }

  Future<void> _getVahules(GetVahulesEvent event, Emitter<VahulState> emit) async {
    try {
      emit(state.copyWith(status: VahulStatus.loading));
      final respose = await ApiService.request("/vahuls", auth: Preferences.token);
      await Future.delayed(Duration(seconds: 2));
      if (respose.statusCode == 200) {
        List<Vahul> list = (respose.data['data'] as List).map((vahul) => Vahul.fromJson(vahul)).toList();
        emit(state.copyWith(
          status: VahulStatus.success,
          vahules: List.from(list)
        ));
      } else {
        emit(state.copyWith(status: VahulStatus.failure, errorMessage: respose.data['message']));
      }
    } catch (e) {
      emit(state.copyWith(status: VahulStatus.failure));
      throw e.toString();
    }
  }

}