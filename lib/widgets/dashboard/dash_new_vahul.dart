import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/screens/vauls/new_vahul_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';

class DashNewVahul extends StatelessWidget {
  const DashNewVahul({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          context.read<NewVahulBloc>().add(NewVahulClean());
          context.read<NewVahulBloc>().add(CurrentVahulClean());
          context.goNamed(NewVahulScreen.routeName);
        },
        splashColor: Colors.white.withAlpha(20),
        highlightColor: Colors.white.withAlpha(60),
        child: Container(
          width: context.isTabletLandscape ? 200 : ((context.isTabletPortrait) ? 220 : 148),
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
              Icon(Icons.add, color: Colors.white, size: context.isTabletLandscape ? 30 : ((context.isTabletPortrait) ? 36 : 24)),
              Text("Nuevo baúl", style: TextStyle(color: Colors.white, fontSize: context.isTabletLandscape ? 22 : ((context.isTabletPortrait) ? 26 : 18)),),
            ],
          )
        ),
      ),
    );
  }
}