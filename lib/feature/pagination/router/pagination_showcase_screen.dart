import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/pagination/application/pagination_provider.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';
import 'package:sandbox/feature/pagination/ui/paged_list_view.dart';
import 'package:sandbox/feature/pagination/ui/pagination_item_component.dart';

import '../ui/components/scroll_to_top_fab.dart';

class PaginationShowcaseScreen extends ConsumerStatefulWidget {
  const PaginationShowcaseScreen({super.key});

  @override
  ConsumerState<PaginationShowcaseScreen> createState() => _PaginationShowcaseScreenState();
}

class _PaginationShowcaseScreenState extends ConsumerState<PaginationShowcaseScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
