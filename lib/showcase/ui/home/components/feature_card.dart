import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/model/showcase_work/showcasework.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';
import 'package:url_launcher/link.dart';

class ShowcaseWorkCard extends ConsumerWidget with UiDimension, UiUtility {
  const ShowcaseWorkCard({
    required this.work,
    super.key,
  });

  final ShowcaseWork work;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MergeSemantics(
      child: Semantics(
        container: true,
        button: true,
        child: Card(
          child: Padding(
            padding: mediumPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: _WorkCardHeader(
                    description: work.description,
                    imagePath: work.imagePath,
                    title: work.title,
                  ),
                ),
                mediumDivider,
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (work.badges.isNotEmpty) Expanded(child: _WorkBadgeBar(badges: work.badges)),
                      _WorkCardActionBar(work: work),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkCardHeader extends ConsumerWidget with UiDimension, UiUtility {
  const _WorkCardHeader({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ShowcaseWorkLogo(imagePath: imagePath),
              smallDivider,
              Text(
                title,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),
        mediumDivider,
        Expanded(
          child: Text(
            description,
            maxLines: 3,
            style: context.textTheme.bodyMedium.withLightBlack,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ShowcaseWorkLogo extends StatelessWidget {
  const _ShowcaseWorkLogo({
    required this.imagePath,
  });

  static const size = 75.0;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
    );
  }
}

class _WorkCardActionBar extends ConsumerWidget {
  const _WorkCardActionBar({required this.work});

  final ShowcaseWork work;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (work.detailsUrl != null)
          Link(
            uri: Uri.tryParse(work.detailsUrl!),
            target: LinkTarget.blank,
            builder: (context, followLink) => FilledButton.icon(
              onPressed: followLink,
              icon: const Icon(Icons.info),
              label: const Text('Dettagli'),
            ),
          ),
      ],
    );
  }
}

class _WorkBadgeBar extends ConsumerWidget {
  const _WorkBadgeBar({
    required this.badges,
  });

  final List<ShowcaseWorkBadge> badges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: UiDimension.smallSize,
      runSpacing: UiDimension.smallSize,
      children: [
        for (final badge in badges) _WorkBadgeWidget(badge: badge),
      ],
    );
  }
}

class _WorkBadgeWidget extends ConsumerWidget with UiUtility, UiDimension, UiShape {
  const _WorkBadgeWidget({required this.badge});

  final ShowcaseWorkBadge badge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Link(
      uri: Uri.tryParse(badge.navigateToUrl ?? ''),
      target: LinkTarget.blank,
      builder: (context, followLink) => InkWell(
        onTap: followLink,
        customBorder: roundedShape,
        child: Ink(
          padding: smallHorizontalPadding.add(extraSmallPadding),
          decoration: BoxDecoration(
            borderRadius: roundedBorderRadius,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Text(
            badge.label,
            style: context.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
