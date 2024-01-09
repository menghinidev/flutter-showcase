import 'package:flutter/material.dart';
import 'package:sandbox/feature/sliver/ui/reorderable_list/sliver_reorderable_list.dart';
import 'package:sandbox/feature/sliver/ui/sliver_app_bar.dart';

class SliverShowcasePage extends StatelessWidget {
  const SliverShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          ShowcaseSliverAppBar(),
          //ShowcaseSliverPersistentHeader(),
          ShowcaseSliverReorderableList(),
          //ShowcaseSliverList(itemCount: 8),
        ],
      ),
    );
  }
}
