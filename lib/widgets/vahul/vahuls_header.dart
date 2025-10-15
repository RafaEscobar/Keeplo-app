import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_bloc.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/vauls/new_vahul_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/simple_button.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class VahulsHeader extends StatelessWidget implements PreferredSize{
  const VahulsHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openOptions({required BuildContext context, required int vahulId}){
    SimpleModal.openModal(
      context: context,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text("Opciones", style: TextStyle(fontSize: Responsive.regularTextSize(context), color: Colors.white, fontWeight: FontWeight.w600),),
            SizedBox(height: 28,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<NewVahulBloc>().add(VahulIsEditionChange(true));
                    context.read<NewVahulBloc>().add(VahulStatusChange(NewVahulStatus.initial));
                    context.goNamed(NewVahulScreen.routeName);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.edit, size: Responsive.modalIconSize(context), color: Colors.white,),
                      Text("Editar", style: TextStyle(color: Colors.white, fontSize: Responsive.sizeModalText(context)),)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    _onDelete(context, vahulId);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.delete, size: Responsive.modalIconSize(context), color: Colors.white,),
                      Text("Eliminar", style: TextStyle(color: Colors.white, fontSize: Responsive.sizeModalText(context)),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDelete(BuildContext context, int vahulId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocListener<VahulBloc, VahulState>(
          listener: (listenerContext, state) {
            if (state.status == VahulStatus.removing) {
              showDialog(
                context: listenerContext,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state.status == VahulStatus.vahulRemoved) {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
              context.read<VahulBloc>().add(GetVahulesEvent());
              context.pushNamed(DashboardScreen.routeName);
            }
          },
          child: Center(
            child: SizedBox(
              width: context.isTabletLandscape ? 600 : (context.isTabletPortrait ? 540 : 400),
              child: AlertDialog(
                backgroundColor: AppTheme.primary,
                title: Text(
                  "¿Realmente deseas eliminar este baúl?",
                  style: TextStyle(fontSize: context.isTablet ? 30 : 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  SimpleButton(
                    text: "Eliminar",
                    callback: () {
                      context.read<VahulBloc>().add(VahulDeleteEvent(vahulId));
                    },
                    backgroundColor: AppTheme.error,
                    textColor: Colors.white,
                    padding: context.isTabletLandscape ? EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2) : EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  ),
                  SizedBox(height: 15,),
                  SimpleButton(
                    text: "Cancelar",
                    callback: () => Navigator.of(context).pop(),
                    padding: context.isTabletLandscape ? EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2) : EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Vahul vahul = context.read<NewVahulBloc>().state.currentVahul!;
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