import 'package:flutter/material.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/dashboard/dash_header.dart';
import 'package:keeplo/widgets/dashboard/dash_search_bar.dart';

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});
  static const String routeName = 'dashboard-screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.primary,
        appBar: DashHeader(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                DashSearchBar(focusNode: _searchFocusNode,)
              ],
            ),
          ),
        )
      ),
    );
  }
}