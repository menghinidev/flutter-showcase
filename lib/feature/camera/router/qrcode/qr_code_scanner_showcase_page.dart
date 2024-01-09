import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/application/barcode_extensions.dart';
import 'package:sandbox/feature/camera/ui/overlay/qr_code_camera_overlay.dart';
import 'package:sandbox/feature/camera/ui/scanner_camera_widget.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

class QRCodeScannerShowcasePage extends ConsumerWidget with DialogManagerProvider {
  const QRCodeScannerShowcasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: ScannerCameraWidget(
        onPermissionDenied: () =>
            getDialogManager(ref).showWarningDialog<void>(text: "Serve l'autorizzazzione a chicco"),
        validFormats: const [BarcodeFormat.qrCode],
        onScanned: (value) {
          final barcode = value.onQRCode();
          if (barcode == null) return;
          getDialogManager(ref).showSuccessDialog<void>(text: 'Contenuto: ${barcode.rawValue}');
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
