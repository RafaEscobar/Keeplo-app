import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';

class NewItemBloc extends Bloc<NewItemBloc, NewItemState>{
  NewItemBloc() : super(NewItemState()){
    //
  }

}