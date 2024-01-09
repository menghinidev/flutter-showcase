import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/pagination/application/state/paginationstate.dart';

class NoMoreItems<T> extends ConsumerWidget {
  const NoMoreItems({required this.state, super.key});
  final PaginationState<T> state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (items, hasMorePages, page) {
        if (hasMorePages) return const SizedBox.shrink();
        return const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'No More Items Found!',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
