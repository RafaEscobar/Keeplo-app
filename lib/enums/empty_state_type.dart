import 'package:flutter/material.dart';
import 'package:keeplo/widgets/simple_empty_state.dart';

enum EmptyStateType {
  noVahuls,
  noSearchVahuls,
  noItems,
  noSearchItems
}

extension EmptyStateTypeExtension on EmptyStateType {
  Widget get emptyState {
    switch (this) {
      case EmptyStateType.noVahuls:
        return SimpleEmptyState(
          label: "Aún no tienes baúles, crea uno.",
          imageUrl: "assets/pictures/empty_list.png",
        );
      case EmptyStateType.noSearchVahuls:
        return SimpleEmptyState(
          label: "No tienes baúles que coincidan con la búsqueda.",
          imageUrl: "assets/pictures/not_found.png",
        );
      case EmptyStateType.noItems:
        return SimpleEmptyState(
          label: "Aún no tienes items en tu baúl, agrega uno.",
          imageUrl: "assets/pictures/empty_list.png",
        );
      case EmptyStateType.noSearchItems:
        return SimpleEmptyState(
          label: "No tienes items que coincidan con la búsqueda.",
          imageUrl: "assets/pictures/not_found.png",
        );
    }
  }
}