import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/ui/camera_viewport_widget.dart';

class CameraShowcaseScreen extends ConsumerWidget {
  const CameraShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return Container();
    return CameraViewportWidget(camera: camera);
  }
}
