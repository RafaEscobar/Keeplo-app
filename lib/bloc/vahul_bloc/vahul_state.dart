import 'package:equatable/equatable.dart';
import 'package:keeplo/models/vahul.dart';

enum VahulStatus { initial, loading, success, failure, searching }
class VahulState extends Equatable{
  final List<Vahul> vahules; //* Listado de vahules
  final List<Vahul> initialVahules; //* Listado inicial (auxiliar) de vahules
  final VahulStatus status; //* Status actual del state
  final String errorMessage; //* Mensaje de error para los toast
  final bool hasMore; //* Bandera para determinar si tenemos más (más paginas) datos que cargar a futuro
  final int page; //* Page actual para el paginado
  final bool loadingMore; //* Bandera para mostrar CircularProgressIndicator si estamos cargando la siguiente page
  final bool isAscOrder; //* Bandera para controlar ordenamiento; true = ordenamiento ascendente | false = ordenamiento descendente (por defecto)

  const VahulState({
    this.vahules = const [],
    this.initialVahules = const [],
    this.status = VahulStatus.initial,
    this.errorMessage = '',
    this.hasMore = false,
    this.page = 1,
    this.loadingMore = false,
    this.isAscOrder = false
  });

  VahulState copyWith({
    List<Vahul>? vahules,
    List<Vahul>? initialVahules,
    VahulStatus? status,
    String? errorMessage,
    bool? hasOrder,
    bool? hasMore,
    int? page,
    bool? loadingMore,
    bool? isAscOrder
  }) => VahulState(
    vahules: vahules ?? this.vahules,
    initialVahules: initialVahules ?? this.initialVahules,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    page: page ?? this.page,
    loadingMore: loadingMore ?? this.loadingMore,
    isAscOrder: isAscOrder ?? this.isAscOrder
  );

  @override
  List<Object?> get props => [vahules, status, errorMessage, initialVahules, hasMore, page, loadingMore, isAscOrder];
}
