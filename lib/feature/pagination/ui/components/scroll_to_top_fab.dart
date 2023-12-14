import 'package:flutter/material.dart';

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset = scrollController.offset;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: scrollOffset > MediaQuery.of(context).size.height * 0.5
              ? FloatingActionButton(
                  tooltip: "Scroll to top",
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () async {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
