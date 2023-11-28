import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

final mlkitControllerProvider = Provider<MlKitController>((ref) {
  return MlKitController();
});

class MlKitController {
  InputImage? createInputImageFromCameraImage(
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

  Future<bool> scan(
    InputImage image, {
    required Function(List<Barcode> values) onScanned,
  }) async {
    var validFormat = [BarcodeFormat.dataMatrix, BarcodeFormat.all];
    var scanner = BarcodeScanner(formats: validFormat);
    var barcodes = await scanner.processImage(image);

    if (barcodes.isNotEmpty) {
      onScanned(barcodes);
      return Future.value(false);
    }

    for (Barcode barcode in barcodes) {
      log(barcode.type.name);
      switch (barcode.type) {
        case BarcodeType.wifi:
          final barcodeWifi = barcode.value as BarcodeWifi;
          break;
        case BarcodeType.url:
          final barcodeUrl = barcode.value as BarcodeUrl;
          break;
        case BarcodeType.unknown:
          // TODO: Handle this case.
          break;
        case BarcodeType.contactInfo:
          // TODO: Handle this case.
          break;
        case BarcodeType.email:
          // TODO: Handle this case.
          break;
        case BarcodeType.isbn:
          // TODO: Handle this case.
          break;
        case BarcodeType.phone:
          // TODO: Handle this case.
          break;
        case BarcodeType.product:
          // TODO: Handle this case.
          break;
        case BarcodeType.sms:
          // TODO: Handle this case.
          break;
        case BarcodeType.text:
          // TODO: Handle this case.
          break;
        case BarcodeType.geoCoordinates:
          // TODO: Handle this case.
          break;
        case BarcodeType.calendarEvent:
          // TODO: Handle this case.
          break;
        case BarcodeType.driverLicense:
          // TODO: Handle this case.
          break;
      }
    }

    return Future.value(true);
  }
}
