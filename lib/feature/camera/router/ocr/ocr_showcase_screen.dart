import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/feature/camera/ui/components/image_cropper_widget.dart';
import 'package:sandbox/feature/camera/ui/ocr_camera_widget.dart';
import 'package:sandbox/feature/camera/ui/overlay/ocr_camera_overlay.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

final _aquiredImageProvider = StateProvider<File?>((ref) {
  return null;
});

class OcrShowcaseScreen extends ConsumerWidget with DialogManager {
  const OcrShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(_aquiredImageProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('OCR')),
      body: image != null
          ? ImageCropperWidget(
              file: image,
              onImageCropped: (file) => submitImage(context, ref, file),
            )
          : OcrCameraWidget(
              onPermissionDenied: () => showWarningDialog(context, text: 'Serve l\'autorizzazzione a chicco'),
              overlayBuilder: (controller) => OcrCameraOverlay(
                onAcquireImage: () => _takePicture(context, ref, controller),
                flashMode: controller.value.flashMode,
                onFlashChanged: (mode) => controller.setFlashMode(mode),
              ),
            ),
    );
  }

  Future<void> _takePicture(
    BuildContext context,
    WidgetRef ref,
    CameraController controller,
  ) async {
    try {
      final pic = await controller.takePicture();
      ref.read(_aquiredImageProvider.notifier).state = File(pic.path);
    } catch (e) {
      log(e.toString());
    }
    return Future.value();
  }

  Future<void> submitImage(
    BuildContext context,
    WidgetRef ref,
    XFile? file,
  ) async {
    if (file == null) {
      ref.read(_aquiredImageProvider.notifier).state = null;
      return Future.value();
    }
    final mlKit = ref.read(mlkitControllerProvider);
    Future<String?> onCompleted(String text) {
      final iban = _findIban(text);
      if (iban != null) {
        showSuccessDialog(
          context,
          text: 'IBAN riconosciuto: $iban',
        ).then((value) => ref.read(_aquiredImageProvider.notifier).state = null);
      } else {
        showWarningDialog(
          context,
          text: 'IBAN non riconosciuto\nValore: $text',
        ).then((value) => ref.read(_aquiredImageProvider.notifier).state = null);
      }
      return Future.value(iban);
    }

    try {
      final image = mlKit.createInputImageFromFile(file);
      await mlKit.scanOCR(image).then(onCompleted);
    } catch (e) {
      log(e.toString());
    }
  }

  String? _findIban(String result) {
    if (result.isEmpty) return null;
    final regex = RegExp('([A-Z]{2}[0-9]{2})[A-Z0-9]{23}');
    final normalized = result.trim().replaceAll('\n', '').replaceAll(' ', '').replaceAll('-', '').replaceAll('O', '0');
    log('Normalized: $normalized');
    return regex.stringMatch(normalized);
  }
}
