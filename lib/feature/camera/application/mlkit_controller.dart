import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mlkitControllerProvider = Provider<MlKitController>((ref) {
  return MlKitController();
});

class MlKitController with InputImageFactory {
  Future<bool> scanBarcode(
    InputImage image, {
    required Future<dynamic> Function(List<Barcode> values) onScanned,
    required List<BarcodeFormat> validFormats,
  }) async {
    var scanner = BarcodeScanner(formats: validFormats);
    var barcodes = await scanner.processImage(image);

    if (barcodes.isNotEmpty) {
      onScanned(barcodes);
      return Future.value(true);
    }

    for (Barcode barcode in barcodes) {
      log(barcode.type.name);
    }

    return Future.value(false);
  }

  Future<String> scanOCR(InputImage image) async {
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(image);
    log('OCR: ${recognizedText.text}');
    return recognizedText.text;
  }
}

mixin InputImageFactory {
  InputImage fromFile(XFile file) {
    return InputImage.fromFile(File(file.path));
  }

  InputImage? fromCameraImage(
    CameraController controller,
    CameraDescription camera,
    CameraImage image,
  ) {
    final orientations = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 90,
      DeviceOrientation.portraitDown: 180,
      DeviceOrientation.landscapeRight: 270,
    };
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = orientations[controller.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
