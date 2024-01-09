import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';

class PaginationDataProvider {
  List<PaginationItem> items = List.generate(100, (index) => PaginationItem(id: index));
  Future<List<PaginationItem>> fetchItems(int page, int limit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final lastItemIndex = page * limit;
    final nextBatchStartIndex = lastItemIndex;
    final nextBatchEndIndex = nextBatchStartIndex + limit;
    if (nextBatchEndIndex > items.length - 1) return items.sublist(nextBatchStartIndex);
    return items.sublist(nextBatchStartIndex, nextBatchEndIndex);
  }
}

final paginationDataProvider = Provider<PaginationDataProvider>((ref) {
  return PaginationDataProvider();
});
