import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';

class SearchField extends StatefulWidget {
  final bool forVahul;
  final FocusNode focusNode;

  const SearchField({
    super.key,
    required this.forVahul,
    required this.focusNode,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (value.isEmpty) {
        if (widget.forVahul) {
          context.read<VahulBloc>().add(GetVahulesEvent());
          context.read<VahulBloc>().add(VahulNewPageEvent(1));
        } else {
          context.read<ItemBloc>().add(GetItemsEvent());
          context.read<ItemBloc>().add(ItemNewPageEvent(1));
        }
      } else {
        if (widget.forVahul) {
          context.read<VahulBloc>().add(SearchVahulEvent(value));
        } else {
          context.read<ItemBloc>().add(SearchItemEvent(value));
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearchChanged,
      cursorColor: Colors.white,
      focusNode: widget.focusNode,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
        labelText: 'Búsqueda',
        labelStyle: TextStyle(color: Colors.grey.shade600),
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 2.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white54, width: 1),
        ),
      ),
      textInputAction: TextInputAction.search,
    );
  }
}
