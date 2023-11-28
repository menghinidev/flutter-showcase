import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/camera_viewport_widget.dart';

final isScanCompletedProvider = StateProvider<bool>((ref) {
  return false;
});

class CameraShowcaseScreen extends ConsumerWidget {
  const CameraShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var camera = ref.watch(currentCameraProvider);
    var isScanCompleted = ref.watch(isScanCompletedProvider);
    if (camera == null) return Container();
    return CameraViewportWidget(
      camera: camera,
      onImageProcessed: (controller, image) async {
        if (isScanCompleted) return Future.value(isScanCompleted);
        var input = ref.read(mlkitControllerProvider).createInputImageFromCameraImage(
              controller,
              camera,
              image,
            );
        if (input == null) return Future.value(false);
        var response = await ref
            .read(mlkitControllerProvider)
            .scan(input, onScanned: (code) => log('Code scanned: ${code.length}'));
        if (response) ref.read(isScanCompletedProvider.notifier).state = true;
      },
    );
  }
}
