import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/sliver/application/sliver_showcase_controller.dart';
import 'package:sandbox/utils/provider_extension.dart';

class ShowcaseSliverGridView extends ConsumerWidget {
  const ShowcaseSliverGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final asyncState = ref.watch(sliverShowcaseStateProvider);
    return asyncState.loadUntil(
      data: (state) => SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: screenWidth * 0.3,
          childAspectRatio: 4 / 3,
        ),
        itemBuilder: (context, index) => Container(
          color: _getColor(index),
          child: Text(state.items[index]),
        ),
      ),
    );
  }

  Color? _getColor(int index) {
    var multiplied = index * 100;
    if (multiplied > 900) multiplied = 0;
    if (multiplied == 0) return Colors.grey;
    return Colors.grey[multiplied];
  }
}
