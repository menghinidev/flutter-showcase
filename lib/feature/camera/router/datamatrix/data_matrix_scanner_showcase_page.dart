import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/application/barcode_extensions.dart';
import 'package:sandbox/feature/camera/ui/overlay/data_matrix_camera_overlay.dart';
import 'package:sandbox/feature/camera/ui/scanner_camera_widget.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

class DataMatrixScannerShowcasePage extends ConsumerWidget with DialogManagerProvider {
  const DataMatrixScannerShowcasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datamatrix')),
      body: ScannerCameraWidget(
        onPermissionDenied: () => getDialogManager(ref).showWarningDialog<void>(
          text: "Serve l'autorizzazzione a chicco",
        ),
        validFormats: const [BarcodeFormat.dataMatrix],
        onScanned: (value) {
          final barcode = value.onDataMatrix();
          if (barcode == null) return;
          getDialogManager(ref).showSuccessDialog<void>(
            text: 'Contenuto: ${barcode.rawValue}',
          );
        },
        overlayBuilder: (controller) => DataMatrixCameraOverlay(
          flashMode: controller.value.flashMode,
          onFlashChanged: (mode) => controller.setFlashMode(mode),
          currentCamera: controller.description,
          onCameraChanged: (value) => controller.setDescription(value),
        ),
      ),
    );
  }
}
