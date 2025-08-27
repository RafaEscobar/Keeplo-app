import 'package:flutter/material.dart';
import 'package:keeplo/widgets/filter_button.dart';

class DashSearchBar extends StatefulWidget {
  const DashSearchBar({super.key});

  @override
  State<DashSearchBar> createState() => _DashSearchBarState();
}

class _DashSearchBarState extends State<DashSearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilterButton(icon: Icons.filter_list_alt, callback: () {},),
        Expanded(
          child: SizedBox(
            height: 44,
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: controller,
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