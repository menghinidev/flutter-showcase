import 'package:flutter/material.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';

class PaginationItemComponent extends StatelessWidget {
  const PaginationItemComponent({required this.item, super.key});
  final PaginationItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item ${item.id}'),
      shape: RoundedRectangleBorder(
        side: const BorderSide(),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
