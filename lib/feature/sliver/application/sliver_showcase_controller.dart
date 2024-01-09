import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/sliver/application/state/slivershowcasestate.dart';

final sliverShowcaseStateProvider =
    StateNotifierProvider<SliverShowcaseController, AsyncValue<SliverShowcaseState>>((ref) {
  return SliverShowcaseController();
});

class SliverShowcaseController extends StateNotifier<AsyncValue<SliverShowcaseState>> {
  SliverShowcaseController() : super(const AsyncLoading()) {
    _init();
  }

  void _init() {
    final initialItems = List.generate(100, (index) => '$index');
    const initialView = SliverShowcaseView.list;
    final newState = SliverShowcaseState(items: initialItems, view: initialView);
    state = AsyncData(newState);
  }

  void reorder(int oldIndex, int newIndex) {
    var normalizedNewIndex = newIndex;
    final actualState = state.whenOrNull(data: (data) => data);
    if (actualState == null) return;
    final currentValues = actualState.items;
    if (oldIndex < normalizedNewIndex) {
      normalizedNewIndex -= 1;
    }
    final value = currentValues[oldIndex];
    final resultList = [...currentValues]
      ..removeAt(oldIndex)
      ..insert(normalizedNewIndex, value);
    final newState = actualState.copyWith(items: resultList);
    state = AsyncData(newState);
  }

  void switchView(SliverShowcaseView view) {
    final actualState = state.whenOrNull(data: (data) => data);
    if (actualState == null) return;
    final newState = actualState.copyWith(view: view);
    state = AsyncData(newState);
  }
}
