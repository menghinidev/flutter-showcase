import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/model/showcase_work/showcasework.dart';
import 'package:sandbox/showcase/ui/animation/animation_utility.dart';
import 'package:sandbox/showcase/ui/home/components/feature_card.dart';
import 'package:sandbox/showcase/ui/home/sections/app_bar.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';
import 'package:sandbox/utils/localization/app_localization_service.dart';

final showcaseWorkProvider = Provider<List<ShowcaseWork>>((ref) {
  return [
    ShowcaseWorkFactory.dappertuttoShowcase(ref.watch(appLocalizationsProvider)),
    ShowcaseWorkFactory.codeSnippetsShowcase(ref.watch(appLocalizationsProvider)),
  ];
});

class HomePage extends HookConsumerWidget with UiUtility {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final items = ref.watch(showcaseWorkProvider);
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const HomePageAppBar(),
        smallSliverDivider,
        const _HomePageHeader(),
        smallSliverDivider,
        _ShowcaseWorkListView(items: items),
      ],
    );
  }
}

class _HomePageHeader extends ConsumerStatefulWidget {
  const _HomePageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __HomePageHeaderState();
}

class __HomePageHeaderState extends ConsumerState<_HomePageHeader> with UiDimension, UiUtility, AnimtionUtility {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        opacity = 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = ref.watch(appLocalizationsProvider);
    return SliverAnimatedOpacity(
      opacity: opacity,
      duration: standardDuration,
      curve: Curves.easeInOut,
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: mediumPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            localization.home_page_header,
            style: context.textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}

class _ShowcaseWorkListView extends StatefulHookConsumerWidget {
  const _ShowcaseWorkListView({required this.items, super.key});

  final List<ShowcaseWork> items;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowcaseWorkListViewState();
}

class _ShowcaseWorkListViewState extends ConsumerState<_ShowcaseWorkListView> with UiDimension {
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
    return SliverAnimatedList(
      key: _listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) => Padding(
        padding: mediumHorizontalPadding,
        child: SizeTransition(
          sizeFactor: animation,
          child: ShowcaseWorkCard(work: items[index]),
        ),
      ),
    );
  }
}
