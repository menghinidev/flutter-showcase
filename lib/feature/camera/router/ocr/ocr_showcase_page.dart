import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/application/controller/ocr/ocr_controller.dart';
import 'package:sandbox/feature/camera/ui/components/image_cropper_widget.dart';
import 'package:sandbox/feature/camera/ui/ocr_camera_widget.dart';
import 'package:sandbox/feature/camera/ui/overlay/ocr_camera_overlay.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';
import 'package:sandbox/utils/provider_extension.dart';

class OcrShowcasePage extends ConsumerWidget with DialogManagerProvider {
  const OcrShowcasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ocrScannerControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('OCR')),
      body: state.loadUntil(
        data: (data) => data.map(
          cameraAquisition: (state) => OcrCameraWidget(
            onPermissionDenied: () => getDialogManager(ref).showWarningDialog(
              text: 'Serve l\'autorizzazzione a chicco',
            ),
            overlayBuilder: (controller) => OcrCameraOverlay(
              onAcquireImage: () => getController(ref).takePicture(controller),
              flashMode: controller.value.flashMode,
              onFlashChanged: (mode) => controller.setFlashMode(mode),
            ),
          ),
          cropping: (state) => ImageCropperWidget(
            file: state.image,
            onImageCropped: (file) => getController(ref).submitImage(),
          ),
        ),
      ),
    );
  }

  OcrScannerScreenController getController(WidgetRef ref) => ref.read(ocrScannerControllerProvider.notifier);
}
