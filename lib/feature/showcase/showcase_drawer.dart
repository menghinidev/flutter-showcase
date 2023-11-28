import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';

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
            if (features.contains(ShowcaseFeature.camera)) ...[
              ShowcaseDrawerMenuItem(
                title: 'Camera',
                icon: camera_icon,
                onTap: () => ref.read(showcasePageProvider.notifier).state = ShowcaseFeature.camera,
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
          ],
        ),
      ),
    );
  }
}
