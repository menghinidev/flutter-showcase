import 'package:flutter/material.dart';

class NoItemsFoundPlaceholder extends StatelessWidget {
  const NoItemsFoundPlaceholder({required this.onRefresh, super.key});
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.replay),
        ),
        const Chip(label: Text('No items Found!')),
      ],
    );
  }
}
