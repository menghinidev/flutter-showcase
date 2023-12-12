import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';
import 'package:sandbox/feature/showcase/router/showcase_router.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';

import 'features.dart';
import 'showcase.dart';
import 'showcase_drawer_menu_item.dart';

class ShowcaseDrawer extends ConsumerWidget with CameraUIProperty {
  const ShowcaseDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var features = ref.watch(showcaseFeturesProvider);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            if (features.contains(ShowcaseFeature.qrCodeScanner)) ...[
              ShowcaseDrawerMenuItem(
                title: 'QR Code',
                icon: cameraIcon,
                onTap: () => ref.read(showcasePageProvider.notifier).state = ShowcaseFeature.qrCodeScanner,
              ),
              const SizedBox(height: 16.0),
            ],
            if (features.contains(ShowcaseFeature.dataMatrixScanner)) ...[
              ShowcaseDrawerMenuItem(
                title: 'Data matrix',
                icon: cameraIcon,
                onTap: () => ref.read(showcasePageProvider.notifier).state = ShowcaseFeature.dataMatrixScanner,
              ),
              const SizedBox(height: 16.0),
            ],
            if (features.contains(ShowcaseFeature.shimmer)) ...[
              ShowcaseDrawerMenuItem(
                title: 'Shimmer',
                icon: Icons.refresh,
                onTap: () => ref.read(showcasePageProvider.notifier).state = ShowcaseFeature.shimmer,
              )
            ],
            if (features.contains(ShowcaseFeature.sliver)) ...[
              ShowcaseDrawerMenuItem(
                title: 'Sliver',
                icon: Icons.list,
                onTap: () => ref.read(showcaseRouterProvider).go(SliverShowcaseRoute.fromHome()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
