import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/sliver/application/sliver_showcase_controller.dart';
import 'package:sandbox/feature/sliver/ui/sliver_item.dart';
import 'package:sandbox/utils/provider_extension.dart';

class ShowcaseSliverReorderableList extends ConsumerWidget {
  const ShowcaseSliverReorderableList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(sliverShowcaseStateProvider);
    return asyncState.loadUntil(
      data: (state) => SliverReorderableList(
        itemCount: state.items.length,
        onReorder: (oldIndex, newIndex) => ref.read(sliverShowcaseStateProvider.notifier).reorder(oldIndex, newIndex),
        itemBuilder: (context, index) => ReorderableDragStartListener(
          key: ValueKey(state.items[index]),
          index: index,
          child: const ShowcaseSliverListItem(),
        ),
      ),
    );
  }
}
