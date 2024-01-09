import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/pagination/application/pagination_provider.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';
import 'package:sandbox/feature/pagination/ui/components/scroll_to_top_fab.dart';
import 'package:sandbox/feature/pagination/ui/paged_list_view.dart';
import 'package:sandbox/feature/pagination/ui/pagination_item_component.dart';

class PaginationShowcasePage extends HookConsumerWidget {
  const PaginationShowcasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: PaginatedListView<PaginationItem>.sliverAutoDispose(
        scrollController: scrollController,
        provider: autoDisposePaginationItemProvider,
        separator: 10,
        builder: (context, value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PaginationItemComponent(item: value),
        ),
      ),
      floatingActionButton: ScrollToTopButton(scrollController: scrollController),
    );
  }
}
