import 'package:flutter/material.dart';
import 'package:keeplo/widgets/simple_empty_state.dart';

enum EmptyStateType {
  noVahuls,
  noSearchVahuls,
}

extension EmptyStateTypeExtension on EmptyStateType {
  Widget get emptyState {
    switch (this) {
      case EmptyStateType.noVahuls:
        return SimpleEmptyState(
          label: "Aún no tienes baúles, crea uno.",
          imageUrl: "assets/pictures/register.png",
        );
      case EmptyStateType.noSearchVahuls:
        return SimpleEmptyState(
          label: "No tienes baúles que coincidan con la búsqueda.",
          imageUrl: "assets/pictures/register.png",
        );
    }
  }
}