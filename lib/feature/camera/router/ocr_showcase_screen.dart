import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/ocr_camera_widget.dart';
import 'package:sandbox/feature/camera/ui/overlay/ocr_camera_overlay.dart';
import 'package:sandbox/feature/showcase/router/showcase_router.dart';

class OcrShowcaseScreen extends ConsumerWidget {
  final Function(String value) onScanned;
  final Function() onPermissionDenied;

  const OcrShowcaseScreen({
    super.key,
    required this.onScanned,
    required this.onPermissionDenied,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OcrCameraWidget(
      onPermissionDenied: onPermissionDenied,
      overlayBuilder: (controller) => OcrCameraOverlay(
        onAcquireImage: () => _takePicture(ref, controller),
        flashMode: controller.value.flashMode,
        onFlashChanged: (mode) => controller.setFlashMode(mode),
      ),
    );
  }

  Future<void> _takePicture(
    WidgetRef ref,
    CameraController controller,
  ) async {
    try {
      final mlKit = ref.read(mlkitControllerProvider);
      void onCompleted(String? text) => ref.read(showcaseRouterProvider).pop();
      final pic = await controller.takePicture();
      final image = mlKit.createInputImageFromFile(pic);
      await mlKit.scanOCR(image).then(onCompleted);
    } catch (e) {
      log(e.toString());
    }
    return Future.value();
  }
}
