import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/model/showcase_work/showcasework.dart';
import 'package:sandbox/showcase/ui/home/components/feature_card.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';

class ShowcaseWorkListView extends StatefulHookConsumerWidget {
  const ShowcaseWorkListView({required this.items, required this.scrollController, super.key});

  final List<ShowcaseWork> items;
  final ScrollController scrollController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ShowcaseWorkListViewState();
}

class ShowcaseWorkListViewState extends ConsumerState<ShowcaseWorkListView> with UiDimension, UiUtility {
  List<ShowcaseWork> items = <ShowcaseWork>[];
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _insertItems();
    });
  }

  Future<void> _insertItems() async {
    for (final item in widget.items) {
      await Future<void>.delayed(const Duration(milliseconds: 100), () {
        items.add(item);
        _listKey.currentState?.insertItem(items.indexOf(item));
      });
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
        const SliverToBoxAdapter(
          child: Icon(Icons.drag_handle_outlined),
        ),
        mediumSliverDivider,
        SliverToBoxAdapter(
          child: Padding(
            padding: mediumHorizontalPadding,
            child: Text(
              'Showcase Work',
              style: context.textTheme.headlineMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: mediumHorizontalPadding,
            child: Text(
              'A list of my showcase work.',
              style: context.textTheme.bodyMedium.withGrayColor,
            ),
          ),
        ),
        mediumSliverDivider,
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: items.length,
          itemBuilder: (context, index, animation) => Padding(
            padding: mediumHorizontalPadding.copyWith(bottom: UiDimension.mediumSize),
            child: SizeTransition(
              sizeFactor: animation,
              child: ShowcaseWorkCard(work: items[index]),
            ),
          ),
        ),
      ],
    );
  }
}
