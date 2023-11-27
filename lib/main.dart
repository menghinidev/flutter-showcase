import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/features.dart';

import 'feature/camera/router/bottom_nav_bar_item.dart';
import 'feature/camera/ui/camera_showcase_screen.dart';
import 'feature/shimmer/router/bottom_nav_bar_item.dart';
import 'feature/shimmer/ui/shimmer_showcase_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SandboxApp()));
}

final sandboxPageProvider = StateProvider<SandboxFeature>((ref) {
  return SandboxFeature.camera;
});

extension IndexFeature on StateController<SandboxFeature> {
  changeFromIndex(int index) {
    var newValue = SandboxFeature.values[index];
    state = newValue;
  }
}

class SandboxApp extends ConsumerWidget {
  const SandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentFeature = ref.watch(sandboxPageProvider);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: <Widget>[
            const CameraShowcaseScreen(),
            const ShimmerShowcaseScreen(),
          ][currentFeature.index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentFeature.index,
          onTap: (index) => ref.read(sandboxPageProvider.notifier).changeFromIndex(index),
          items: [
            SandboxCameraRouteNavigationItem(),
            SandboxShimmerRouteNavigationItem(),
          ],
        ),
      ),
    );
  }
}
