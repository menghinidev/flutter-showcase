import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/paginationstate.dart';

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({required this.fetchNextItems}) : super(const PaginationState.loading()) {
    fetchFirstBatch();
  }

  final Future<List<T>> Function(int page, int limit) fetchNextItems;
  final int itemsPerBatch = 20;

  void _updateData({
    required List<T> currentList,
    required List<T> result,
    required int page,
  }) {
    var hasMorePages = result.length == itemsPerBatch;
    var newValues = [...currentList];
    if (result.isNotEmpty) newValues.addAll(result);
    state = PaginationState.data(
      newValues,
      hasMorePages: hasMorePages,
      page: page,
    );
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const PaginationState.loading();
      final List<T> result = await fetchNextItems(0, itemsPerBatch);
      _updateData(result: result, currentList: <T>[], page: 0);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  Future<void> fetchNextBatch() async {
    var prevState = state.mapOrNull(data: (value) => value);
    if (prevState == null) return Future.value();
    var items = prevState.items;
    var page = prevState.page;
    var nextPage = page + 1;
    if (!prevState.hasMorePages) return Future.value();
    if (state == PaginationState<T>.onGoingLoading(items)) {
      log("Rejected");
      return;
    }

    log("Fetching next batch of items");

    state = PaginationState.onGoingLoading(items);

    try {
      final result = await fetchNextItems(nextPage, itemsPerBatch);
      log(result.length.toString());
      _updateData(currentList: items, result: result, page: nextPage);
    } catch (e, stk) {
      log("Error fetching next page", error: e, stackTrace: stk);
      state = PaginationState.onGoingError(items, e, stk);
    }
  }
}
