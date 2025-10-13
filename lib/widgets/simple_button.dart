import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

class SimpleButton extends StatelessWidget{
  const SimpleButton({
    super.key,
    required this.text,
    required this.callback,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    this.backgroundColor = Colors.white,
    this.textColor = AppTheme.primary,
  });
  final String text;
  final Function() callback;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: GestureDetector(
        onTap: callback,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: context.isTabletLandscape ? 28 : context.isTabletPortrait ? 22 : 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}