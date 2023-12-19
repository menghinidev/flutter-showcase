import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/components/camera_ui_properties.dart';

import '../components/overlay_header_section.dart';
import 'camera_scope_overlay.dart';

class DataMatrixCameraOverlay extends StatelessWidget with CameraUIProperty {
  final CameraDescription currentCamera;
  final FlashMode flashMode;
  final String description;
  final Function(CameraDescription value) onCameraChanged;
  final Function(FlashMode mode) onFlashChanged;
  DataMatrixCameraOverlay({
    super.key,
    required this.description,
    required this.onCameraChanged,
    required this.currentCamera,
    required this.flashMode,
    required this.onFlashChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScannerScope.dataMatrix(),
        CameraOverlayHeader(
          description: description,
          flashMode: flashMode,
          onFlashChanged: onFlashChanged,
        ),
      ],
    );
  }
}
