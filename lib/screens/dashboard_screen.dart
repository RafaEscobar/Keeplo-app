import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_state.dart';
import 'package:keeplo/enums/empty_state_type.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/dashboard/dash_header.dart';
import 'package:keeplo/widgets/dashboard/dash_new_vahul.dart';
import 'package:keeplo/widgets/dashboard/simple_search_bar.dart';
import 'package:keeplo/widgets/dashboard/vahul_card.dart';

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});
  static const String routeName = 'dashboard-screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final double _threshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VahulBloc>().add(GetVahulesEvent());
    },);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    VahulBloc bloc = context.read<VahulBloc>();

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _threshold) {
      if (bloc.state.hasMore && !bloc.state.loadingMore) {
        bloc.add(LoadMoreVahulesEvent(bloc.state.page + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(didPop) return;
      },
      child: GestureDetector(
        onTap: () => _searchFocusNode.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme.primary,
          appBar: DashHeader(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                spacing: 26,
                children: [
                  SimpleSearchBar(focusNode: _searchFocusNode,),
                  BlocBuilder<VahulBloc, VahulState>(
                    builder: (context, state) {
                      if (state.status == VahulStatus.loading) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.white,)
                          ,)
                        );
                      }
                      List<Vahul> list = state.vahules;
                      if (list.isEmpty && state.status == VahulStatus.searching) return EmptyStateType.noSearchVahuls.emptyState;
                      if (list.isEmpty) return EmptyStateType.noVahuls.emptyState;
                      return  Expanded(
                        child: RefreshIndicator(
                          color: AppTheme.primary,
                          backgroundColor: Colors.white,
                          onRefresh: () async {
                            context.read<VahulBloc>().add(GetVahulesEvent());
                          },
                          child: GridView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: context.isTabletLandscape ? 6 : context.isTabletPortrait ? 4 : 3,
                              crossAxisSpacing: context.isTabletLandscape ? 20 : context.isTabletPortrait ? 10 : 40,
                              mainAxisSpacing: 0,
                              childAspectRatio: context.isTabletLandscape ? 1 : context.isTabletPortrait ? 0.9 : 0.6,
                            ),
                            itemBuilder: (context, index) {
                              return VahulCard(vahul: list[index], callBack: () => _searchFocusNode.unfocus(),);
                            },
                          ),
                        )
                      );
                    },
                  ),
                  BlocSelector<VahulBloc, VahulState, bool>(
                    selector: (state) => state.loadingMore,
                    builder: (context, loadingMore) {
                      return (loadingMore) ? CircularProgressIndicator(color: Colors.white,) : Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: DashNewVahul()
        ),
      ),
    );
  }
}