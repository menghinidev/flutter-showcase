import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/camera_viewport_widget.dart';

class ScannerCameraWidget extends ConsumerStatefulWidget {
  final Function(List<Barcode> value) onScanned;
  final List<BarcodeFormat> validFormats;
  final Function()? onManualInsert;
  final Widget Function(CameraController) overlayBuilder;
  final Function() onPermissionDenied;

  const ScannerCameraWidget({
    super.key,
    required this.onScanned,
    required this.validFormats,
    required this.overlayBuilder,
    required this.onPermissionDenied,
    this.onManualInsert,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScannerCameraWidgetState();
}

class _ScannerCameraWidgetState extends ConsumerState<ScannerCameraWidget> {
  bool hasScanned = false;

  void _setHasScanned() {
    if (mounted) {
      hasScanned = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return Container();
    return CameraViewportWidget(
      camera: camera,
      onPermissionDenied: widget.onPermissionDenied,
      overlayBuilder: widget.overlayBuilder,
      onImageProcessed: (controller, image) async {
        if (hasScanned) return Future.value(true);
        var input =
            ref.read(mlkitControllerProvider).createInputImageFromCameraImage(
                  controller,
                  camera,
                  image,
                );
        if (input == null) return Future.value(false);
        return await ref
            .read(mlkitControllerProvider)
            .scan(input, validFormats: widget.validFormats, onScanned: (code) {
          if (!hasScanned) {
            widget.onScanned(code);
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                content: Text('Scanned: ${code.length}'),
                showCloseIcon: true,
              ),
            );
            _setHasScanned();
          }
          return Future.value();
        });
      },
    );
  }
}
