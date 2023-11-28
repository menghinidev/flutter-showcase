import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sandbox/feature/camera/application/barcode_extensions.dart';
import 'package:sandbox/feature/showcase/features.dart';
import 'package:sandbox/feature/showcase/showcase.dart';

import '../ui/overlay/qr_code_camera_overlay.dart';
import '../ui/scanner_camera_widget.dart';

class QRCodeScannerShowcaseScreen extends ConsumerWidget {
  final Function(Barcode value) onScanned;
  final Function()? onManualInsert;
  final Function(CameraException error)? onPermissionDenied;

  const QRCodeScannerShowcaseScreen({
    super.key,
    required this.onScanned,
    this.onManualInsert,
    this.onPermissionDenied,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScannerCameraWidget(
      onPermissionDenied: onPermissionDenied,
      validFormats: const [BarcodeFormat.qrCode],
      onScanned: (value) {
        var barcode = value.onQRCode();
        if (barcode == null) return;
        onScanned(barcode);
      },
      onManualInsert: onManualInsert,
      overlayBuilder: (controller) => QRCodeCameraOverlay(
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
