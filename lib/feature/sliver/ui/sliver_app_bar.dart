import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShowcaseSliverAppBar extends ConsumerWidget {
  const ShowcaseSliverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar.large(
      title: const Text('Page title'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      actions: [
        IconButton.filledTonal(
          onPressed: () => print('ao'),
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }
}
