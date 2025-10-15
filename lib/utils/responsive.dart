import 'package:flutter/material.dart';

class Responsive {
  // Método para redimencionar valor de (.sp, .h y .w)	Scaled Pixels para textos
  static double resize({required double size, double reduction = 1}) => size * reduction;

  // Tamaño regular de texto
  static double regularTextSize(BuildContext context) => context.isTabletLandscape ? 28 : (context.isTabletPortrait ? 24 : 20);

  // Tamaño minimo de texto
  static double minTextSize(BuildContext context) => context.isTabletLandscape ? 26 : 16;

  // Tamaño minimo de texto
  static double modal(BuildContext context) => context.isTabletLandscape ? 26 : 16;

  // Tamaño de textos de opciones en modal
  static double sizeModalOptions(BuildContext context) => context.isTabletLandscape ? 24 : 18;

  // Tamaño de textos simples en modal
  static double sizeModalText(BuildContext context) => context.isTabletLandscape ? 20 : 18;

  // Tamaño de textos de opciones en modal
  static double modalIconSize(BuildContext context) => context.isTabletLandscape ? 38 : 32;
}

const double kTabletBreakpoint = 600.0;

extension DeviceExtensions on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= kTabletBreakpoint; // Tablet
  bool get isTabletLandscape => isTablet && MediaQuery.of(this).orientation == Orientation.landscape; // Tablet horizontal
  bool get isTabletPortrait => isTablet && MediaQuery.of(this).orientation == Orientation.portrait; // Tablet vertical
}
