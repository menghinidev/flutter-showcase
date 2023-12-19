import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/components/camera_viewport_widget.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';

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
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerCameraWidgetState();
}

class _ScannerCameraWidgetState extends ConsumerState<ScannerCameraWidget> {
  bool hasScanned = false;

  @override
  Widget build(BuildContext context) {
    var camera = ref.watch(currentCameraProvider);
    if (camera == null) return const LoadingWidget();
    return CameraViewportWidget(
      camera: camera,
      onPermissionDenied: widget.onPermissionDenied,
      overlayBuilder: widget.overlayBuilder,
      onImageProcessed: (controller, image) => _processImage(camera, controller, image),
    );
  }

  void _setHasScanned() {
    if (mounted) {
      hasScanned = true;
      setState(() {});
    }
  }

  _processImage(CameraDescription camera, CameraController controller, CameraImage image) async {
    if (hasScanned) return Future.value(true);
    final mlkitController = ref.read(mlkitControllerProvider);
    var input = mlkitController.createInputImageFromCameraImage(
      controller,
      camera,
      image,
    );
    if (input == null) return Future.value(false);
    return await mlkitController.scanBarcode(
      input,
      validFormats: widget.validFormats,
      onScanned: (code) {
        if (!hasScanned) {
          widget.onScanned(code);
          _setHasScanned();
        }
        return Future.value();
      },
    );
  }
}
