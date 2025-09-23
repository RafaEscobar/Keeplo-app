import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

class SimpleButton extends StatelessWidget{
  const SimpleButton({
    super.key,
    required this.text,
    required this.callback,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
  });
  final String text;
  final Function() callback;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context){
    bool isHorizontal = context.isTabletLandscape;
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: GestureDetector(
        onTap: callback,
        child: Text(
          text,
          style: TextStyle(color: AppTheme.primary, fontSize: isHorizontal ? 28 : Responsive.resize(size:22.sp, reduction: .8), fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}