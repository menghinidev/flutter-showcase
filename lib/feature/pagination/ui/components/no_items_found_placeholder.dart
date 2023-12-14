import 'package:flutter/material.dart';

class NoItemsFoundPlaceholder extends StatelessWidget {
  final Function() onRefresh;

  const NoItemsFoundPlaceholder({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.replay),
        ),
        const Chip(label: Text("No items Found!")),
      ],
    );
  }
}
