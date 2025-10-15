import 'package:flutter/material.dart';
import 'package:keeplo/utils/simple_toast.dart';

class Loader {
  static void show(BuildContext context){
    showDialog(
      context: context,
      barrierColor:Colors.black.withAlpha(80),
      builder: (context) {
        return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }

  static void hide(BuildContext context) => Navigator.pop(context);

  static Future<void> runLoad({required BuildContext context, required Future<void> Function() asyncFunction, int secondsDelayed = 0}) async {
    try {
      show(context);
      await asyncFunction();
      await Future.delayed(Duration(seconds: secondsDelayed));
    } catch (e) {
      if (context.mounted) SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
    } finally {
      if (context.mounted) hide(context);
    }
  }
}