import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/pagination/application/pagination_notifier.dart';
import 'package:sandbox/feature/pagination/application/state/paginationstate.dart';
import 'package:sandbox/feature/pagination/ui/components/error_widget.dart';
import 'package:sandbox/feature/pagination/ui/components/no_items_found_placeholder.dart';
import 'package:sandbox/feature/pagination/ui/components/no_more_items_placeholder.dart';
import 'package:sandbox/utils/builder/empty_data_builder.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';

class PaginatedListView<T> extends ConsumerWidget {
  const PaginatedListView({
    required this.scrollController,
    required this.provider,
    required this.builder,
    required this.separator,
    super.key,
    this.restorationId,
  })  : autodisposeProvider = null,
        autodispose = false,
        sliver = false;

  const PaginatedListView.autoDispose({
    required this.scrollController,
    required AutoDisposeStateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider,
    required this.builder,
    required this.separator,
    super.key,
    this.restorationId,
  })  : provider = null,
        autodisposeProvider = provider,
        autodispose = true,
        sliver = false;

  const PaginatedListView.sliver({
    required this.scrollController,
    required this.provider,
    required this.builder,
    required this.separator,
    super.key,
    this.restorationId,
  })  : autodisposeProvider = null,
        autodispose = false,
        sliver = true;

  const PaginatedListView.sliverAutoDispose({
    required this.scrollController,
    required AutoDisposeStateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider,
    required this.builder,
    required this.separator,
    super.key,
    this.restorationId,
  })  : provider = null,
        autodisposeProvider = provider,
        autodispose = true,
        sliver = true;

  final ScrollController scrollController;
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>>? provider;
  final AutoDisposeStateNotifierProvider<PaginationNotifier<T>, PaginationState<T>>? autodisposeProvider;
  final Widget Function(BuildContext context, T value) builder;
  final double separator;
  final String? restorationId;
  final bool autodispose;
  final bool sliver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autodispose ? autodisposeProvider! : provider!);
    scrollController.addListener(() => _fetchNextBatchListener(context, ref));
    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(autodispose ? autodisposeProvider! : provider!);
        return Future.value();
      },
      child: _buildBody(context, state, ref),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PaginationState<T> state,
    WidgetRef ref,
  ) {
    if (sliver) return _buildSliverListView(context, state, ref);
    return _buildListView(context, state, ref);
  }

  Widget _buildSliverListView(
    BuildContext context,
    PaginationState<T> state,
    WidgetRef ref,
  ) {
    return CustomScrollView(
      controller: scrollController,
      restorationId: restorationId,
      slivers: [
        _SliverItemsList(
          state: state,
          builder: builder,
          separator: separator,
          onRefresh: () => ref.read((autodispose ? autodisposeProvider! : provider!).notifier).fetchFirstBatch(),
        ),
        SliverToBoxAdapter(child: NoMoreItems(state: state)),
        _OnGoingBottomWidget(state: state),
      ],
    );
  }

  Widget _buildListView(
    BuildContext context,
    PaginationState<T> state,
    WidgetRef ref,
  ) {
    return _ItemsList(
      state: state,
      builder: builder,
      onRefresh: () => ref.read((autodispose ? autodisposeProvider! : provider!).notifier).fetchFirstBatch(),
      separator: separator,
      controller: scrollController,
      restorationId: restorationId,
    );
  }

  void _fetchNextBatchListener(BuildContext context, WidgetRef ref) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final delta = MediaQuery.of(context).size.width * 0.20;
    if (maxScroll - currentScroll <= delta) {
      ref.read((autodispose ? autodisposeProvider! : provider!).notifier).fetchNextBatch();
    }
  }
}

class _SliverItemsList<T> extends StatelessWidget {
  const _SliverItemsList({
    required this.state,
    required this.builder,
    required this.onRefresh,
    required this.separator,
    super.key,
  });
  final PaginationState<T> state;
  final Future<void> Function() onRefresh;
  final double separator;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (items, hasMorePages, page) => EmptyDataWidget(
        emptyCondition: items.isEmpty,
        applySliver: true,
        emptyPlaceholderBuilder: (context) => NoItemsFoundPlaceholder(onRefresh: onRefresh),
        childBuilder: (context) => _buildSliverListView(context, items),
      ),
      loading: () => const SliverToBoxAdapter(child: Center(child: LoadingWidget())),
      error: (e, stk) => const SliverToBoxAdapter(child: PaginationListErrorWidget()),
      onGoingLoading: (items) => _buildSliverListView(context, items),
      onGoingError: (items, e, stk) => _buildSliverListView(context, items),
    );
  }

  Widget _buildSliverListView(BuildContext context, List<T> items) {
    return _SliverItemsListBuilder<T>(
      items: items,
      builder: builder,
      separator: separator,
    );
  }
}

class _SliverItemsListBuilder<T> extends StatelessWidget {
  const _SliverItemsListBuilder({
    required this.items,
    required this.builder,
    required this.separator,
    super.key,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T value) builder;
  final double separator;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => builder(context, items[index]),
      separatorBuilder: (context, index) => SizedBox.square(dimension: separator),
      itemCount: items.length,
    );
  }
}

class _ItemsList<T> extends StatelessWidget {
  const _ItemsList({
    required this.state,
    required this.builder,
    required this.onRefresh,
    required this.separator,
    required this.controller,
    super.key,
    this.restorationId,
  });
  final PaginationState<T> state;
  final Future<void> Function() onRefresh;
  final double separator;
  final ScrollController controller;
  final String? restorationId;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (items, hasMorePages, page) => EmptyDataWidget(
        emptyCondition: items.isEmpty,
        emptyPlaceholderBuilder: (context) => NoItemsFoundPlaceholder(onRefresh: onRefresh),
        childBuilder: (context) => _buildListView(context, items),
      ),
      loading: () => const Center(child: LoadingWidget()),
      error: (e, stk) => const PaginationListErrorWidget(),
      onGoingLoading: (items) => _buildListView(context, items),
      onGoingError: (items, e, stk) => _buildListView(context, items),
    );
  }

  Widget _buildListView(BuildContext context, List<T> items) {
    return _ItemsListBuilder<T>(
      items: items,
      builder: builder,
      separator: separator,
      controller: controller,
      restorationId: restorationId,
    );
  }
}

class _ItemsListBuilder<T> extends StatelessWidget {
  const _ItemsListBuilder({
    required this.items,
    required this.builder,
    required this.separator,
    required this.controller,
    super.key,
    this.restorationId,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T value) builder;
  final double separator;
  final ScrollController controller;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => builder(context, items[index]),
      separatorBuilder: (context, index) => SizedBox.square(dimension: separator),
      itemCount: items.length,
      controller: controller,
      restorationId: restorationId,
    );
  }
}

class _OnGoingBottomWidget<T> extends StatelessWidget {
  const _OnGoingBottomWidget({required this.state, super.key});
  final PaginationState<T> state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          onGoingLoading: (items) => const Center(child: CircularProgressIndicator()),
          onGoingError: (items, e, stk) => const Center(
            child: Column(
              children: [
                Icon(Icons.info),
                SizedBox(height: 20),
                Text(
                  'Something Went Wrong!',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
