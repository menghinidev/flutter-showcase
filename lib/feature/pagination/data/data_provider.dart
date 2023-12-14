import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/pagination/model/paginationitem.dart';

class PaginationDataProvider {
  var items = List.generate(100, (index) => PaginationItem(id: index));
  Future<List<PaginationItem>> fetchItems(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 1));
    var lastItemIndex = page * limit;
    var nextBatchStartIndex = lastItemIndex;
    var nextBatchEndIndex = nextBatchStartIndex + limit;
    if (nextBatchEndIndex > items.length - 1) return items.sublist(nextBatchStartIndex);
    return items.sublist(nextBatchStartIndex, nextBatchEndIndex);
  }
}

final paginationDataProvider = Provider<PaginationDataProvider>((ref) {
  return PaginationDataProvider();
});
