import 'package:flutter/material.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';

class PaginationItemComponent extends StatelessWidget {
  final PaginationItem item;
  const PaginationItemComponent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item ${item.id}'),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
