import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class VahulsHeader extends StatelessWidget implements PreferredSize{
  const VahulsHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openOptions({required BuildContext context, required int vahulId}){
    SimpleModal.openModal(
      context: context,
      body: BlocListener<VahulBloc, VahulState>(
        listener: (sheetContext, state) {
          if (state.status == VahulStatus.vahulRemoved) {
            Navigator.of(sheetContext).pop();
            context.read<VahulBloc>().add(GetVahulesEvent());
          } else if(state.status == VahulStatus.loading) {
            showDialog(
              context: context,
              builder:(context) => Center(
                child: CircularProgressIndicator(color: Colors.white,)
              ,)
            );
          }
        },
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text("Opciones", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),),
              SizedBox(height: 28,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _onDelete(context, vahulId),
                    child: Column(
                      children: [
                        Icon(Icons.edit, size: 32, color: Colors.white,),
                        Text("Editar", style: TextStyle(color: Colors.white, fontSize: 18),)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.delete, size: 32, color: Colors.white,),
                      Text("Eliminar", style: TextStyle(color: Colors.white, fontSize: 18),)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void _onDelete(BuildContext context, int vahulId) {
    context.read<VahulBloc>().add(VahulDeleteEvent(vahulId));
  }

  @override
  Widget build(BuildContext context) {
    Vahul vahul = context.read<VahulBloc>().state.currentVahul!;
    return AppBar(
      backgroundColor: AppTheme.primaryTwo,
      title: Text(vahul.name, style: TextStyle(fontSize: Responsive.regularTextSize(context))),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () => _openOptions(context: context, vahulId: vahul.id),
            child: Icon(Icons.more_vert_outlined, size: context.isTabletLandscape ? 38 : 27),
          ),
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}