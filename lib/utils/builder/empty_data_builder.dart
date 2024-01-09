import 'package:flutter/material.dart';
import 'package:sandbox/utils/builder/empty_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    required this.emptyCondition,
    required this.childBuilder,
    this.emptyPlaceholderBuilder,
    this.applySliver = false,
    super.key,
  });
  final bool emptyCondition;
  final Widget Function(BuildContext context) childBuilder;
  final Widget Function(BuildContext context)? emptyPlaceholderBuilder;
  final bool applySliver;

  @override
  Widget build(BuildContext context) {
    if (!emptyCondition) return childBuilder(context);
    if (emptyPlaceholderBuilder != null && applySliver) {
      return SliverToBoxAdapter(child: emptyPlaceholderBuilder!(context));
    }
    if (emptyPlaceholderBuilder != null) return emptyPlaceholderBuilder!(context);
    if (applySliver) return const SliverToBoxAdapter(child: EmptyWidget());
    return const EmptyWidget();
  }
}
