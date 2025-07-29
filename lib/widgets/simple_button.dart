import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

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
        child: Text(text, style: TextStyle(color: AppTheme.primary, fontSize: Responsive.resize(size:22.sp, reduction: .8), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
    );
  }
}