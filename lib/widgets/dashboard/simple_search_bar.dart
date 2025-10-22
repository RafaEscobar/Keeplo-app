import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/widgets/filter_button.dart';
import 'package:keeplo/widgets/dashboard/search_field.dart';

class SimpleSearchBar extends StatelessWidget {
  const SimpleSearchBar({super.key, required this.focusNode, this.forVahul = true});
  final FocusNode focusNode;
  final bool forVahul;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilterButton(
          icon: Icons.sort,
          callback: () {
            if (forVahul) {
              context.read<VahulBloc>().add(VahulOrderChange());
              context.read<VahulBloc>().add(VahulNewPageEvent(1));
              context.read<VahulBloc>().add(GetVahulesEvent());
            } else {
              context.read<ItemBloc>().add(ItemOrderChange());
              context.read<ItemBloc>().add(ItemNewPageEvent(1));
              context.read<ItemBloc>().add(GetItemsEvent());
            }
          },
        ),
        Expanded(
          child: SizedBox(
            height: 44,
            child: SearchField(forVahul: forVahul, focusNode: focusNode,)
          ),
        ),
      ],
    );
  }
}