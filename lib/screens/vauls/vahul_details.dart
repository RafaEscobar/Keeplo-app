import 'package:flutter/material.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/enums/empty_state_type.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/dashboard/simple_search_bar.dart';
import 'package:keeplo/widgets/vahul/vahuls_header.dart';

class VahulDetails extends StatefulWidget {
  const VahulDetails({super.key});
  static const String routeName = 'vahul-details';

  @override
  State<VahulDetails> createState() => _VahulDetailsState();
}

class _VahulDetailsState extends State<VahulDetails> {
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final double _threshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemBloc>().add(GetItemEvent());
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
    ItemBloc bloc = context.read<ItemBloc>();

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _threshold) {
      if (bloc.state.hasMore && !bloc.state.loadingMore) {
        bloc.add(LoadMoreItemsEvent(bloc.state.page + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.primary,
        appBar: VahulsHeader(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              spacing: 26,
              children: [
                SimpleSearchBar(focusNode: _searchFocusNode, forVahul: false, ),
                BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    if (state.status == ItemStatus.loading) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white,)
                        ,)
                      );
                    }
                    List<Item> list = state.items;
                    if (list.isEmpty && state.status == ItemStatus.searching) return EmptyStateType.noSearchItems.emptyState;
                    if (list.isEmpty) return EmptyStateType.noItems.emptyState;
                    return  Expanded(
                      child: RefreshIndicator(
                        color: AppTheme.primary,
                        backgroundColor: Colors.white,
                        onRefresh: () async {
                          context.read<ItemBloc>().add(GetItemEvent());
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
                            return Text(list[index].name);
                          },
                        ),
                      )
                    );
                  },
                ),
                BlocSelector<ItemBloc, ItemState, bool>(
                  selector: (state) => state.loadingMore,
                  builder: (context, loadingMore) {
                    return (loadingMore) ? CircularProgressIndicator(color: Colors.white,) : Container();
                  },
                ),
              ],
            ),
          ),
        ),
        //floatingActionButton: DashNewVahul()
      ),
    );
  }
}