import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class DashHeader extends StatelessWidget implements PreferredSize{
  const DashHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openProfile(BuildContext context){
    SimpleModal.openModal(
      context: context,
      body: Column(
        children: [
          Text("Perfil"),
          Text("Nombre coompleto"),
          Text("correo"),
          Row(
            children: [
              GestureDetector(
                onTap: () => (),
                child: Icon(Icons.edit),
              ),
              GestureDetector(
                onTap: () => (),
                child: Icon(Icons.login_rounded),
              )
            ],
          )
        ],
      )
    );
  }

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
            onTap: () => _openProfile(context),
            child: Icon(Icons.person),
          ),
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}