class Responsive {

  // Método para redimencionar valor de (.sp, .h y .w)	Scaled Pixels para textos
  static double resize({required double size, double reduction = 1}) => size * reduction;
}