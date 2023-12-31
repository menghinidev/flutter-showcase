import 'package:flutter/material.dart';

class ShowcaseListItem extends StatelessWidget {
  const ShowcaseListItem({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
