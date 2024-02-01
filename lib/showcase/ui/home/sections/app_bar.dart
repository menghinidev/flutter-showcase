import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/ui/animation/animation_utility.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';
import 'package:sandbox/utils/localization/app_localization_service.dart';
import 'package:sandbox/utils/logger/logger_manager.dart';

class HomePageAppBar extends ConsumerStatefulWidget {
  const HomePageAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageAppBar();
}

class _HomePageAppBar extends ConsumerState<HomePageAppBar> with UiUtility, AnimtionUtility, UiDimension, UiShape {
  final appBarHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    final localization = ref.watch(appLocalizationsProvider);
    return SliverAppBar(
      title: Text(localization.title),
      leading: const Icon(
        Icons.person,
      ),
      forceElevated: true,
      floating: true,
      snap: true,
      actions: [
        IconButton.outlined(
          icon: const Icon(
            Icons.settings,
            semanticLabel: 'Settings',
          ),
          onPressed: () => ref.logMessage('Go to settings'),
        ),
        smallDivider,
        IconButton.outlined(
          icon: const Icon(
            Icons.info,
            semanticLabel: 'Info',
          ),
          onPressed: () => ref.logMessage('Go to info'),
        ),
        smallDivider,
      ],
      expandedHeight: kToolbarHeight + 48.0 + 24,
      collapsedHeight: kToolbarHeight + 48.0 + 24,
      elevation: elevation,
      shape: bottomRounded,
      flexibleSpace: Container(
        alignment: Alignment.bottomCenter,
        padding: mediumPadding.copyWith(top: kToolbarHeight),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                spacing: UiDimension.mediumSize,
                runSpacing: UiDimension.mediumSize,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () => ref.logMessage('Send email'),
                    icon: const Icon(Icons.flutter_dash),
                    label: const Text(
                      'Flutter Dash',
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => ref.logMessage('Call'),
                    icon: const Icon(Icons.call),
                    label: Text(
                      localization.home_page_header_action_send_email,
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => ref.logMessage('Call'),
                    icon: const Icon(Icons.call_end),
                    label: Text(
                      localization.home_page_header_action_send_email,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
