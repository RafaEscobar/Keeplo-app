import 'package:flutter/material.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/enums/empty_state_type.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/dashboard/simple_search_bar.dart';
import 'package:keeplo/widgets/items/item_card.dart';
import 'package:keeplo/widgets/items/new_item.dart';
import 'package:keeplo/widgets/vahul/vahul_info.dart';
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
      int vahulId = context.read<VahulBloc>().state.currentVahul!.id;
      context.read<ItemBloc>().add(SetVahulIdEvent(vahulId));
      context.read<ItemBloc>().add(GetItemsEvent());
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
    Vahul vahul = context.read<VahulBloc>().state.currentVahul!;
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
                VahulInfo(imagePath: 'imagePath', description: vahul.description),
                Divider(
                  height: .6,
                  color: Colors.white30,
                ),
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
                    if (list.isEmpty && state.status == ItemStatus.searching) {
                      return EmptyStateType.noSearchItems.emptyState;
                    }
                    if (list.isEmpty) return EmptyStateType.noItems.emptyState;
                    return  Expanded(
                      child: RefreshIndicator(
                        color: AppTheme.primary,
                        backgroundColor: Colors.white,
                        onRefresh: () async {
                          context.read<ItemBloc>().add(GetItemsEvent());
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ItemCard(item: list[index],);
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
        floatingActionButton: NewItem()
      ),
    );
  }
}