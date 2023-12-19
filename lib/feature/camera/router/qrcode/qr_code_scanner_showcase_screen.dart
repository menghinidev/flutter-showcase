import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/camera/application/barcode_extensions.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

import '../../ui/overlay/qr_code_camera_overlay.dart';
import '../../ui/scanner_camera_widget.dart';

class QRCodeScannerShowcaseScreen extends ConsumerWidget with DialogManager {
  const QRCodeScannerShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: ScannerCameraWidget(
        onPermissionDenied: () => showWarningDialog(context, text: 'Serve l\'autorizzazzione a chicco'),
        validFormats: const [BarcodeFormat.qrCode],
        onScanned: (value) {
          var barcode = value.onQRCode();
          if (barcode == null) return;
          showSuccessDialog(context, text: 'Contenuto: ${barcode.rawValue}');
        },
        overlayBuilder: (controller) => QRCodeCameraOverlay(
          flashMode: controller.value.flashMode,
          onFlashChanged: (mode) => controller.setFlashMode(mode),
          currentCamera: controller.description,
          onCameraChanged: (value) => controller.setDescription(value),
        ),
      ),
    );
  }
}
