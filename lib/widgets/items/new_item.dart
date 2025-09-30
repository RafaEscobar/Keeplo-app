import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_bloc.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_event.dart';
import 'package:keeplo/screens/items/new_item_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

class NewItem extends StatelessWidget{
  const NewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          context.read<NewItemBloc>().add(NewItemClean());
          context.goNamed(NewItemScreen.routeName);
        },
        splashColor: Colors.white.withAlpha(20),
        highlightColor: Colors.white.withAlpha(60),
        child: Container(
          width: context.isTabletLandscape ? 220 : 148,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6,
            children: [
              Icon(Icons.add, color: Colors.white, size: context.isTabletLandscape ? 36 : 24,),
              Text("Nuevo item", style: TextStyle(color: Colors.white, fontSize: Responsive.minTextSize(context)),),
            ],
          )
        ),
      ),
    );
  }
}