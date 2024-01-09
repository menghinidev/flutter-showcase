import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/feature/camera/ui/components/camera_ui_properties.dart';

class CameraOverlayHeader extends StatelessWidget with CameraUIProperty {
  const CameraOverlayHeader({
    required this.flashMode,
    required this.onFlashChanged,
    super.key,
    this.description,
  });
  final FlashMode flashMode;
  final String? description;
  final void Function(FlashMode mode) onFlashChanged;

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
            padding: const EdgeInsets.all(16),
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
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.qr_code,
                  size: 56,
                  color: Colors.white,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.75,
                    ),
                    child: Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
