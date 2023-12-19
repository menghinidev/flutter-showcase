import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/ui/components/camera_viewport_widget.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';

import '../application/available_camera_provider.dart';

class OcrCameraWidget extends ConsumerWidget {
  const OcrCameraWidget({
    required this.overlayBuilder,
    required this.onPermissionDenied,
    super.key,
  });

  final Widget Function(CameraController controller) overlayBuilder;
  final void Function() onPermissionDenied;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return const LoadingWidget();
    return CameraViewportWidget(
      camera: camera,
      onPermissionDenied: onPermissionDenied,
      overlayBuilder: overlayBuilder,
    );
  }
}
