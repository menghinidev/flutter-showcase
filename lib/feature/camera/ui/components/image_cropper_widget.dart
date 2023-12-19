import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/ui/components/acquire_image_button.dart';
import 'package:sandbox/utils/storage/storage_manager.dart';

final cropControllerProvider = Provider.autoDispose<CropController>((ref) {
  const cropRect = Rect.fromLTRB(0.1, 0.25, 0.9, 0.35);
  return CropController(defaultCrop: cropRect);
});

class ImageCropperWidget extends ConsumerWidget {
  final File file;
  final Future Function(XFile? value) onImageCropped;
  const ImageCropperWidget({
    super.key,
    required this.file,
    required this.onImageCropped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cropControllerProvider);
    return Stack(
      children: [
        CropImage(
          controller: controller,
          image: Image.file(file),
          gridColor: Colors.white,
          scrimColor: Colors.grey.withOpacity(0.5),
          alwaysShowThirdLines: true,
          minimumImageSize: 50,
        ),
        Positioned(
          bottom: 32,
          left: 32,
          right: 32,
          child: AcquireImageButton(
            onPressed: () => crop(controller, ref),
          ),
        ),
      ],
    );
  }

  Future<void> crop(CropController controller, WidgetRef ref) async {
    final bitmap = await controller.croppedBitmap();
    final data = await bitmap.toByteData(format: ui.ImageByteFormat.png);
    final bytes = data!.buffer.asUint8List();
    final result = await ref.read(storageManagerProvider).createFile(bytes, 'png');
    await onImageCropped(XFile(result.path));
  }
}
