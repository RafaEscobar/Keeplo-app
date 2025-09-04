import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/screens/forms/new_vahul_screen.dart';

class DashNewVahul extends StatelessWidget {
  const DashNewVahul({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.goNamed(NewVahulScreen.routeName),
        splashColor: Colors.white.withAlpha(20),
        highlightColor: Colors.white.withAlpha(60),
        child: Container(
          width: 145,
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
              Icon(Icons.add, color: Colors.white,),
              Text("Nuevo baúl", style: TextStyle(color: Colors.white),),
            ],
          )
        ),
      ),
    );
  }
}