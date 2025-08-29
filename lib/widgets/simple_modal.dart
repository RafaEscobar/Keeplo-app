import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
              child: body
            ),
          ),
        );
      },
    );
  }
}