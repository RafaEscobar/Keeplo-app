import 'package:equatable/equatable.dart';
import 'package:keeplo/models/item.dart';

enum ItemStatus {initial, loading, success, failure, searching, removing, itemRemoved}

class ItemState extends Equatable{
  final List<Item> items; //* Listado de items
  final List<Item> initialItems; //* Listado inicial (auxiliar) de items
  final ItemStatus status; //* Status actual del state
  final String errorMessage; //* Mensaje de error para los toast
  final bool hasMore; //* Bandera para determinar si tenemos más (más paginas) datos que cargar a futuro
  final int page; //* Page actual para el paginado
  final bool loadingMore; //* Bandera para mostrar CircularProgressIndicator si estamos cargando la siguiente page
  final bool isAscOrder; //* Bandera para controlar ordenamiento; true = ordenamiento ascendente | false = ordenamiento descendente (por defecto)
  final int vahulId; //* Variable para el id del vahul actual

  const ItemState({
    this.items = const [],
    this.initialItems = const [],
    this.status = ItemStatus.initial,
    this.errorMessage = '',
    this.hasMore = false,
    this.page = 1,
    this.loadingMore = false,
    this.isAscOrder = false,
    this.vahulId = -1
  });

  ItemState copyWith({
    List<Item>? items,
    List<Item>? initialItems,
    ItemStatus? status,
    String? errorMessage,
    bool? hasMore,
    int? page,
    bool? loadingMore,
    bool? isAscOrder,
    int? vahulId
  }) => ItemState(
    items: items ?? this.items,
    initialItems: initialItems ?? this.initialItems,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    page: page ?? this.page,
    loadingMore: loadingMore ?? this.loadingMore,
    isAscOrder: isAscOrder ?? this.isAscOrder,
    vahulId: vahulId ?? this.vahulId
  );

  @override
  List<Object?> get props => [
    items,
    initialItems,
    status,
    errorMessage,
    hasMore,
    page,
    loadingMore,
    isAscOrder,
    vahulId
  ];
}