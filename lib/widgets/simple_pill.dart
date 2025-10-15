import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';

class SimplePill extends StatelessWidget {
  const SimplePill({super.key, required this.status});
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: status ? AppTheme.info : AppTheme.error,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(status ? "Disponible" : "No disponible" , style: TextStyle(color: status ? AppTheme.primary : Colors.white),),
    );
  }
}