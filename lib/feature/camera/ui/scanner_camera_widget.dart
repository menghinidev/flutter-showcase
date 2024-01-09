import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/application/available_camera_provider.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/components/camera_viewport_widget.dart';
import 'package:sandbox/utils/loader/loading_widget.dart';

class ScannerCameraWidget extends ConsumerStatefulWidget {
  const ScannerCameraWidget({
    required this.onScanned,
    required this.validFormats,
    required this.overlayBuilder,
    required this.onPermissionDenied,
    super.key,
    this.onManualInsert,
  });
  final FutureOr<void> Function(List<Barcode> value) onScanned;
  final List<BarcodeFormat> validFormats;
  final void Function()? onManualInsert;
  final Widget Function(CameraController) overlayBuilder;
  final void Function() onPermissionDenied;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerCameraWidgetState();
}

class _ScannerCameraWidgetState extends ConsumerState<ScannerCameraWidget> {
  bool hasScanned = false;

  @override
  Widget build(BuildContext context) {
    final camera = ref.watch(currentCameraProvider);
    if (camera == null) return const LoadingWidget();
    return CameraViewportWidget(
      resolution: ResolutionPreset.medium,
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

  Future<Object> _processImage(CameraDescription camera, CameraController controller, CameraImage image) async {
    if (hasScanned) return Future.value(true);
    final mlkitController = ref.read(mlkitControllerProvider);
    final input = mlkitController.fromCameraImage(
      controller,
      camera,
      image,
    );
    if (input == null) return Future.value(false);
    return mlkitController.scanBarcode(
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
