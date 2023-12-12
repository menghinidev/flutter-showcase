import 'package:flutter/material.dart';
import 'package:sandbox/feature/sliver/ui/sliver_list.dart';

import '../ui/sliver_app_bar.dart';

class SliverShowcaseScreen extends StatelessWidget {
  const SliverShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          ShowcaseSliverAppBar(),
          //ShowcaseSliverPersistentHeader(),
          ShowcaseSliverList(itemCount: 8),
        ],
      ),
    );
  }
}
