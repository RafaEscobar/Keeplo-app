import 'package:flutter/material.dart';

class Responsive {

  // Método para redimencionar valor de (.sp, .h y .w)	Scaled Pixels para textos
  static double resize({required double size, double reduction = 1}) => size * reduction;
}

const double kTabletBreakpoint = 600.0;

extension DeviceExtensions on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= kTabletBreakpoint; // Tablet
  bool get isTabletLandscape => isTablet && MediaQuery.of(this).orientation == Orientation.landscape; // Tablet horizontal
  bool get isTabletPortrait => isTablet && MediaQuery.of(this).orientation == Orientation.portrait; // Tablet vertical
}
