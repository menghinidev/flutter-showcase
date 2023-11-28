import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/showcase/features.dart';
import 'package:sandbox/feature/showcase/showcase.dart';

import '../application/barcode_extensions.dart';
import '../ui/overlay/data_matrix_camera_overlay.dart';
import '../ui/scanner_camera_widget.dart';

class DataMatrixScannerShowcaseScreen extends ConsumerWidget {
  final Function(Barcode value) onScanned;
  final Function()? onManualInsert;
  final String description;
  final Function(CameraException error)? onPermissionDenied;

  const DataMatrixScannerShowcaseScreen({
    super.key,
    required this.onScanned,
    required this.description,
    this.onManualInsert,
    this.onPermissionDenied,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScannerCameraWidget(
      onPermissionDenied: onPermissionDenied,
      validFormats: const [BarcodeFormat.dataMatrix],
      onScanned: (value) {
        var barcode = value.onDataMatrix();
        if (barcode == null) return;
        onScanned(barcode);
      },
      onManualInsert: onManualInsert,
      overlayBuilder: (controller) => DataMatrixCameraOverlay(
        onManualInsert: () => ref.read(showcasePageProvider.notifier).state = ShowcaseFeature.shimmer,
        description: "Inquadra il QR Code sul tuo bollettino CBILL/PagoPA all'interno dell'area evidenziata",
        flashMode: controller.value.flashMode,
        onFlashChanged: (mode) => controller.setFlashMode(mode),
        currentCamera: controller.description,
        onCameraChanged: (value) => controller.setDescription(value),
      ),
    );
  }
}
