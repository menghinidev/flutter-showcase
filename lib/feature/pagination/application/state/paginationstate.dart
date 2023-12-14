import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginationstate.freezed.dart';

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.data(
    List<T> items, {
    required bool hasMorePages,
    required int page,
  }) = Data;
  const factory PaginationState.loading() = Loading;
  const factory PaginationState.error(Object? e, [StackTrace? stk]) = Error;
  const factory PaginationState.onGoingLoading(List<T> items) = OnGoingLoading;
  const factory PaginationState.onGoingError(List<T> items, Object? e, [StackTrace? stk]) = OnGoingError;
}
