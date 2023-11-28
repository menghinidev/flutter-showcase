import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../camera_ui_properties.dart';
import '../components/overlay_header_section.dart';
import 'camera_scope_overlay.dart';

class QRCodeCameraOverlay extends StatelessWidget with CameraUIProperty {
  final CameraDescription currentCamera;
  final FlashMode flashMode;
  final String description;
  final Function(CameraDescription value) onCameraChanged;
  final Function(FlashMode mode) onFlashChanged;
  final Function() onManualInsert;
  QRCodeCameraOverlay({
    super.key,
    required this.description,
    required this.onCameraChanged,
    required this.currentCamera,
    required this.flashMode,
    required this.onFlashChanged,
    required this.onManualInsert,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScannerScope.qrCode(),
        CameraOverlayHeader(description: description, flashMode: flashMode, onFlashChanged: onFlashChanged),
        Positioned(
          bottom: 32,
          left: 32,
          right: 32,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
            onPressed: onManualInsert,
            child: const Text('Inserisci manualmente'),
          ),
        ),
      ],
    );
  }
}
