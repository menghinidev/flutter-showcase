import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';
import 'package:sandbox/utils/localization/app_localization_service.dart';

class HomePageHeader extends ConsumerWidget with UiDimension, UiShape {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = ref.watch(appLocalizationsProvider);
    return SliverToBoxAdapter(
      child: Container(
        padding: smallPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: roundedBorderRadius,
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
          animatedTexts: [
            TypewriterAnimatedText(
              localization.home_page_header,
              textStyle: context.textTheme.titleMedium,
              curve: Curves.decelerate,
              cursor: '',
              speed: const Duration(milliseconds: 10),
            ),
          ],
        ),
      ),
    );
  }
}
