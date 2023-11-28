import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../camera/router/bottom_nav_bar_item.dart';
import '../camera/router/camera_showcase_screen.dart';
import '../shimmer/router/bottom_nav_bar_item.dart';
import '../shimmer/router/shimmer_showcase_screen.dart';
import 'features.dart';
import 'showcase_drawer.dart';

final showcasePageProvider = StateProvider<ShowcaseFeature>((ref) {
  return ShowcaseFeature.camera;
});

extension IndexFeature on StateController<ShowcaseFeature> {
  changeFromIndex(int index) {
    var newValue = ShowcaseFeature.values[index];
    state = newValue;
  }
}

class ShowcaseScreen extends ConsumerWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentFeature = ref.watch(showcasePageProvider);
    return Scaffold(
      drawer: const ShowcaseDrawer(),
      appBar: AppBar(title: const Text('Showcase App')),
      body: SafeArea(
        child: <Widget>[
          const CameraShowcaseScreen(),
          const ShimmerShowcaseScreen(),
        ][currentFeature.index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentFeature.index,
        onTap: (index) => ref.read(showcasePageProvider.notifier).changeFromIndex(index),
        items: [
          SandboxCameraRouteNavigationItem(),
          SandboxShimmerRouteNavigationItem(),
        ],
      ),
    );
  }
}
