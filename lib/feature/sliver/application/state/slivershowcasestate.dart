import 'package:freezed_annotation/freezed_annotation.dart';

part 'slivershowcasestate.freezed.dart';

enum SliverShowcaseView { list, grid }

@freezed
class SliverShowcaseState with _$SliverShowcaseState {
  factory SliverShowcaseState({
    required List<String> items,
    required SliverShowcaseView view,
  }) = _SliverShowcaseState;
}
