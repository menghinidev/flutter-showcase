import 'dart:io';

import 'package:camera/camera.dart';

mixin CameraImageFormatProvider {
  ImageFormatGroup? get platformFormat {
    if (Platform.isAndroid) return ImageFormatGroup.nv21;
    if (Platform.isIOS) return ImageFormatGroup.bgra8888;
    return null;
  }
}
