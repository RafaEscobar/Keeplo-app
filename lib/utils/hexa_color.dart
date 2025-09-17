import 'package:flutter/material.dart';

class HexaColor {
  static String getCode(Color color){
    int r = (color.r * 255).round();
    int g = (color.g * 255).round();
    int b = (color.b * 255).round();
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }
}