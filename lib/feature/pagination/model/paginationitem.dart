import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginationitem.freezed.dart';

@freezed
class PaginationItem with _$PaginationItem {
  factory PaginationItem({required int id}) = _PaginationItem;
}
