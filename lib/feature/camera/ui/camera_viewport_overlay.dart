import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';

class CameraViewportScopeOverlay extends StatelessWidget {
  final padding = 75.0;
  final aspectRatio = 1;
  final color = const Color.fromRGBO(173, 216, 230, 0.5);
  const CameraViewportScopeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;
      if (parentAspectRatio < aspectRatio) {
        horizontalPadding = padding;
        verticalPadding = (constraints.maxHeight - ((constraints.maxWidth - 2 * padding) / aspectRatio)) / 2;
      } else {
        verticalPadding = padding;
        horizontalPadding = (constraints.maxWidth - ((constraints.maxHeight - 2 * padding) * aspectRatio)) / 2;
      }
      return Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: horizontalPadding,
              color: color,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: horizontalPadding,
              color: color,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              border: Border.all(color: color),
            ),
          )
        ],
      );
    });
  }
}

class CameraViewportOverlay extends StatelessWidget with CameraUIProperty {
  final CameraDescription currentCamera;
  final FlashMode flashMode;
  final String description;
  final Function(CameraDescription value) onCameraChanged;
  final Function(FlashMode mode) onFlashChanged;
  final Function() onManualInsert;
  CameraViewportOverlay({
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
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 0,
              top: 0,
              width: 56,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () =>
                      flashMode == FlashMode.torch ? onFlashChanged(FlashMode.off) : onFlashChanged(FlashMode.torch),
                  icon: Icon(flashMode == FlashMode.torch ? flashOffIcon : flashOnIcon),
                ),
              ),
            ),
            Positioned(
              width: 100,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.qr_code,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
        const CameraViewportScopeOverlay(),
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
