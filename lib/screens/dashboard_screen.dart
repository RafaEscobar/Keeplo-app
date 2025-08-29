import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/dashboard/dash_header.dart';
import 'package:keeplo/widgets/dashboard/dash_new_vahul.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VahulBloc>().add(GetVahulesEvent());
    },);
  }

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
                DashSearchBar(focusNode: _searchFocusNode,),
                // AQUI
              ],
            ),
          ),
        ),
        floatingActionButton: DashNewVahul()
      ),
    );
  }
}