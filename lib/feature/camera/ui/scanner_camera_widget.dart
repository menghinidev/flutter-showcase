import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/camera_viewport_widget.dart';

final isScanCompletedProvider = StateProvider<bool>((ref) {
  return false;
});

class ScannerCameraWidget extends ConsumerWidget {
  final Function(List<Barcode> value) onScanned;
  final List<BarcodeFormat> validFormats;
  final Function()? onManualInsert;
  final Widget Function(CameraController) overlayBuilder;
  final Function(CameraException error)? onPermissionDenied;

  const ScannerCameraWidget({
    super.key,
    required this.onScanned,
    required this.validFormats,
    required this.overlayBuilder,
    this.onManualInsert,
    this.onPermissionDenied,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return Container();
    return CameraViewportWidget(
      camera: camera,
      onPermissionDenied: onPermissionDenied,
      overlayBuilder: overlayBuilder,
      onImageProcessed: (controller, image) async {
        var isScanCompleted = ref.read(isScanCompletedProvider);
        if (isScanCompleted) return Future.value(true);
        var input = ref.read(mlkitControllerProvider).createInputImageFromCameraImage(
              controller,
              camera,
              image,
            );
        if (input == null) return Future.value(false);
        return await ref.read(mlkitControllerProvider).scan(input, validFormats: validFormats, onScanned: (code) {
          var isScanCompleted = ref.read(isScanCompletedProvider);
          if (!isScanCompleted) {
            onScanned(code);
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                content: Text('Scanned: ${code.length}'),
                showCloseIcon: true,
              ),
            );
            ref.read(isScanCompletedProvider.notifier).state = true;
          }
          return Future.value();
        });
      },
    );
  }
}
