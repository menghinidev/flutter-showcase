import 'package:flutter/material.dart';
import 'package:sandbox/feature/shimmer/ui/shimmer_component.dart';

class ShowcaseSliverList extends StatelessWidget {
  final int itemCount;

  const ShowcaseSliverList({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => const ShowcaseSliverListItem(),
      separatorBuilder: (_, __) => const SizedBox.square(dimension: 16.0),
      itemCount: itemCount,
    );
  }
}

class ShowcaseSliverListItem extends StatelessWidget {
  const ShowcaseSliverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseShimmerWidget();
  }
}
