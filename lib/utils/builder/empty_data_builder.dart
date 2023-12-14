import 'package:flutter/material.dart';

import 'empty_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  final bool emptyCondition;
  final Widget Function(BuildContext context) childBuilder;
  final Widget Function(BuildContext context)? emptyPlaceholderBuilder;
  final bool applySliver;

  const EmptyDataWidget({
    required this.emptyCondition,
    required this.childBuilder,
    this.emptyPlaceholderBuilder,
    this.applySliver = false,
    Key? key,
  }) : super(key: key);

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
