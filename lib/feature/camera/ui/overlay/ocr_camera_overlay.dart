import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';

import '../components/acquire_image_button.dart';
import '../components/overlay_header_section.dart';

class OcrCameraOverlay extends StatelessWidget with CameraUIProperty {
  OcrCameraOverlay({
    required this.flashMode,
    required this.onFlashChanged,
    required this.onAcquireImage,
    super.key,
  });

  final FlashMode flashMode;
  final void Function(FlashMode mode) onFlashChanged;
  final VoidCallback onAcquireImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraOverlayHeader(
          flashMode: flashMode,
          onFlashChanged: onFlashChanged,
        ),
        Positioned(
          bottom: 32,
          left: 32,
          right: 32,
          child: AcquireImageButton(onPressed: onAcquireImage),
        ),
      ],
    );
  }
}
