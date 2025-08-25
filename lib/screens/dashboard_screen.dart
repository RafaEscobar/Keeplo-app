import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});
  static const String routeName = 'dashboard-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryTwo,
        leading: null,
        automaticallyImplyLeading: false,
        title: Text("Mis vahules"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(context.watch<AuthBloc>().state.user?.fullName ?? '---'),
      )
    );
  }
}