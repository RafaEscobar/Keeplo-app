import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';

class SimpleButton extends StatelessWidget{
  const SimpleButton({super.key, required this.text, required this.callback});
  final String text;
  final Function() callback;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: GestureDetector(
        onTap: callback,
        child: Text(text, style: TextStyle(color: AppTheme.primary, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
    );
  }
}