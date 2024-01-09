import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/pagination/application/pagination_notifier.dart';
import 'package:sandbox/feature/pagination/application/state/paginationstate.dart';
import 'package:sandbox/feature/pagination/data/data_provider.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';

final paginationItemProvider =
    StateNotifierProvider<PaginationNotifier<PaginationItem>, PaginationState<PaginationItem>>((ref) {
  return PaginationNotifier(
    fetchNextItems: (page, limit) => ref.read(paginationDataProvider).fetchItems(page, limit),
  );
});

final autoDisposePaginationItemProvider =
    StateNotifierProvider.autoDispose<PaginationNotifier<PaginationItem>, PaginationState<PaginationItem>>((ref) {
  return PaginationNotifier(
    fetchNextItems: (page, limit) => ref.read(paginationDataProvider).fetchItems(page, limit),
  );
});
