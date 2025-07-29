import 'package:flutter/material.dart';

class Responsive {

  // Método para redimencionar valor de (.sp, .h y .w)	Scaled Pixels para textos
  static double resize({required double size, double reduction = 1}) => size * reduction;

  // Método para comprobar si estamos ante una table horizontal
  static bool isHorizontalTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600 && MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
}