import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SimpleToast {
  static void success({required BuildContext context, required String message, double size = 18, double iconSize = 70}) => showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        icon: Icon(Icons.check_circle_outline, size: iconSize.sp, color: Colors.white,),
        message: message,
        textStyle: TextStyle(fontSize: size.sp, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        messagePadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      ),
  );

  static void info({required BuildContext context, required String message, double size = 18, double iconSize = 70}) => showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: AppTheme.secondary,
        icon: Icon(Icons.question_mark, size: iconSize.sp, color: Colors.white,),
        message: message,
        textStyle: TextStyle(fontSize: size.sp, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        messagePadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      ),
  );

  static void error({required BuildContext context, required String message, double size = 18, double iconSize = 70}) => showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        backgroundColor: AppTheme.error,
        icon: Icon(Icons.close, size: iconSize.sp, color: Colors.white,),
        message: message,
        textStyle: TextStyle(fontSize: size.sp, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        messagePadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      ),
  );
}