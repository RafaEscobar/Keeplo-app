import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/dashboard/dash_header.dart';
import 'package:keeplo/widgets/dashboard/dash_search_bar.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});
  static const String routeName = 'dashboard-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: DashHeader(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              DashSearchBar()
            ],
          ),
        ),
      )
    );
  }
}