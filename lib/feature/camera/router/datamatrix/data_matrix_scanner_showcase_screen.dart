import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

import '../../application/barcode_extensions.dart';
import '../../ui/overlay/data_matrix_camera_overlay.dart';
import '../../ui/scanner_camera_widget.dart';

class DataMatrixScannerShowcaseScreen extends ConsumerWidget with DialogManager {
  const DataMatrixScannerShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datamatrix')),
      body: ScannerCameraWidget(
        onPermissionDenied: () => showWarningDialog(context, text: 'Serve l\'autorizzazzione a chicco'),
        validFormats: const [BarcodeFormat.dataMatrix],
        onScanned: (value) {
          var barcode = value.onDataMatrix();
          if (barcode == null) return;
          showSuccessDialog(context, text: 'Contenuto: ${barcode.rawValue}');
        },
        overlayBuilder: (controller) => DataMatrixCameraOverlay(
          description: "Inquadra il QR Code sul tuo bollettino CBILL/PagoPA all'interno dell'area evidenziata",
          flashMode: controller.value.flashMode,
          onFlashChanged: (mode) => controller.setFlashMode(mode),
          currentCamera: controller.description,
          onCameraChanged: (value) => controller.setDescription(value),
        ),
      ),
    );
  }
}
