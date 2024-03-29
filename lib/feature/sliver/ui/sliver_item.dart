import 'package:flutter/material.dart';

class ShowcaseSliverListItem extends StatelessWidget {
  const ShowcaseSliverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: const Text('Elemento'),
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
