//* Clase abstracta base
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/models/vahul.dart';

//* Clase abstracta base
abstract class VahulEvent {}

//* Evento para cambiar valor de la variable -page-
class VahulNewPageEvent extends VahulEvent {
  final int newPage;
  VahulNewPageEvent(this.newPage);
}

//* Evento para generar busqueda por nombre en el listado de vahules
class SearchVahulEvent extends VahulEvent {
  final String text;
  SearchVahulEvent(this.text);
}

//* Evento para lanzar carga de siguiente page
class LoadMoreVahulesEvent extends VahulEvent {
  final int newPage;
  LoadMoreVahulesEvent(this.newPage);
}

//* Método para cambiar el status del state actual
class VahulChangeStatus extends VahulEvent {
  final VahulStatus status;
  VahulChangeStatus(this.status);
}

//* Método para lanzar petición para eliminar un vahul
class VahulDeleteEvent extends VahulEvent {
  final int vahulId;
  VahulDeleteEvent(this.vahulId);
}

//* Método para setear vahul actual
class SetCurrentVahulEvent extends VahulEvent {
  final Vahul currentVahul;
  SetCurrentVahulEvent(this.currentVahul);
}

//* Evento para obtener listado de vahules
class GetVahulesEvent extends VahulEvent {}

//* Evento para lanzar limpieza del state
class VahulCleanBloc extends VahulEvent {}

//* Evento para cambiar dínamicamente valor del ordenamiento de la lista de vahules
class VahulOrderChange extends VahulEvent {}