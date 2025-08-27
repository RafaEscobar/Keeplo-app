import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';

class DashHeader extends StatelessWidget implements PreferredSize{
  const DashHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryTwo,
      leading: null,
      automaticallyImplyLeading: false,
      title: Text("Mis vahules"),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () {

            },
            child: Icon(Icons.person),
          ),
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}