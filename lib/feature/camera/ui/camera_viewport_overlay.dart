import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';
import 'package:sandbox/utils/provider_extension.dart';

class CameraViewportOverlay extends ConsumerWidget {
  final CameraDescription currentCamera;
  final Function(CameraDescription value) onCameraChanged;
  const CameraViewportOverlay({
    super.key,
    required this.onCameraChanged,
    required this.currentCamera,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cameras = ref.watch(availableCamerasProvider);
    return cameras.loadUntil(
      data: (value) => Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 16,
          children: [
            for (var camera in value) ...[
              ElevatedButton(
                onPressed: currentCamera == camera ? null : () => onCameraChanged(camera),
                child: Icon(camera.icon),
              ),
            ],
          ],
        ),
      ),
    );
  }
}