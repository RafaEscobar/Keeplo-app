import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';

class SimpleModal {
  static void openModal({required BuildContext context, required Widget body}) {
    showModalBottomSheet(
      useSafeArea: true,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      builder: (modalContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primary,
                border: Border(top: BorderSide(width: 1, color: Colors.white)),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
              child: body
            ),
          ),
        );
      },
    );
  }
}