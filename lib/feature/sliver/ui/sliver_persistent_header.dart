import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/sliver/application/sliver_showcase_controller.dart';
import 'package:sandbox/feature/sliver/application/state/slivershowcasestate.dart';

class ShowcaseSliverPersistentHeader extends ConsumerWidget {
  const ShowcaseSliverPersistentHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ShowcaseSliverPersistentHeaderDelegate(ref: ref),
    );
  }
}

class ShowcaseSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  ShowcaseSliverPersistentHeaderDelegate({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      children: [
        FilterChip.elevated(
          label: const Text('List'),
          avatar: const Icon(Icons.list_outlined),
          onSelected: (val) => ref.read(sliverShowcaseStateProvider.notifier).switchView(SliverShowcaseView.list),
        ),
        FilterChip.elevated(
          label: const Text('Grid'),
          avatar: const Icon(Icons.grid_4x4_outlined),
          onSelected: (val) => ref.read(sliverShowcaseStateProvider.notifier).switchView(SliverShowcaseView.grid),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
