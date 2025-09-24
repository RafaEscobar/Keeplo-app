import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

class VahulsHeader extends StatelessWidget implements PreferredSize{
  const VahulsHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ItemState itemState = context.read<ItemBloc>().state;
    return AppBar(
      backgroundColor: AppTheme.primaryTwo,
      title: Text(itemState.currentVahul!.name, style: TextStyle(fontSize: Responsive.regularTextSize(context))),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () => {},
            child: Icon(Icons.more_vert_outlined, size: context.isTabletLandscape ? 38 : 27),
          ),
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}