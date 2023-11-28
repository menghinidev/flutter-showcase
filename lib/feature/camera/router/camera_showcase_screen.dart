import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/camera_viewport_widget.dart';

final isScanCompletedProvider = StateProvider<bool>((ref) {
  return false;
});

class CameraShowcaseScreen extends ConsumerWidget {
  final Function(String? value) onScanned;
  final Function()? onManualInsert;
  final String description;
  final Function(CameraException error)? onPermissionDenied;

  const CameraShowcaseScreen({
    super.key,
    required this.onScanned,
    this.onManualInsert,
    required this.description,
    this.onPermissionDenied,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return Container();
    return CameraViewportWidget(
      camera: camera,
      overlayDescription: description,
      onPermissionDenied: onPermissionDenied,
      onImageProcessed: (controller, image) async {
        /* var isScanCompleted = ref.read(isScanCompletedProvider);
        if (isScanCompleted) return Future.value(true); */
        var input = ref.read(mlkitControllerProvider).createInputImageFromCameraImage(
              controller,
              camera,
              image,
            );
        if (input == null) return Future.value(false);
        return await ref.read(mlkitControllerProvider).scan(input, onScanned: (code) {
          var isScanCompleted = ref.read(isScanCompletedProvider);
          log('Code found');
          if (!isScanCompleted) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                content: Text('Scanned: ${code.length}'),
                showCloseIcon: true,
              ),
            );
            ref.read(isScanCompletedProvider.notifier).state = true;
          }
          return Future.value();
        });
      },
    );
  }
}
