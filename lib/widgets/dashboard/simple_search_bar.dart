import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/widgets/filter_button.dart';

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
              context.read<ItemBloc>().add(GetItemEvent());
            }
          },
        ),
        Expanded(
          child: SizedBox(
            height: 44,
            child: TextField(
              onChanged: (value) {
                forVahul ?
                  context.read<VahulBloc>().add(SearchVahulEvent(value)) :
                  context.read<ItemBloc>().add(SearchItemEvent(value));
              },
              cursorColor: Colors.white,
              focusNode: focusNode,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                errorText: null,
                errorStyle: const TextStyle(color: Color.fromARGB(255, 168, 17, 17,),),
                labelText: 'Busqueda',
                labelStyle: TextStyle(color: Colors.grey.shade600,),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                // Borde cuando está habilitado (un poco más grueso)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                // Borde cuando tiene foco (opcional: más visible)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 2.5),
                ),
                // Si quieres un borde distinto cuando esté deshabilitado:
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white54, width: 1),
                ),
              ),
              textInputAction: TextInputAction.go,
            ),
          ),
        ),
      ],
    );
  }
}