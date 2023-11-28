import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/camera_ui_properties.dart';

class CameraOverlayHeader extends StatelessWidget with CameraUIProperty {
  final FlashMode flashMode;
  final String description;
  final Function(FlashMode mode) onFlashChanged;
  const CameraOverlayHeader({
    super.key,
    required this.flashMode,
    required this.description,
    required this.onFlashChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          left: 0,
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.qr_code,
                  size: 56,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              LayoutBuilder(
                builder: (context, constraints) => ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.75),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
