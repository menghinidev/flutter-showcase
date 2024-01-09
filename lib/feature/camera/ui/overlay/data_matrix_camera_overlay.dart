import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/components/camera_ui_properties.dart';
import 'package:sandbox/feature/camera/ui/components/overlay_header_section.dart';
import 'package:sandbox/feature/camera/ui/overlay/camera_scope_overlay.dart';

class DataMatrixCameraOverlay extends StatelessWidget with CameraUIProperty {
  DataMatrixCameraOverlay({
    required this.onCameraChanged,
    required this.currentCamera,
    required this.flashMode,
    required this.onFlashChanged,
    super.key,
    this.description,
  });
  final CameraDescription currentCamera;
  final FlashMode flashMode;
  final String? description;
  final void Function(CameraDescription value) onCameraChanged;
  final void Function(FlashMode mode) onFlashChanged;

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
