import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

extension CameraUIDescription on CameraDescription {
  IconData get icon {
    if (lensDirection == CameraLensDirection.back) {
      return Icons.photo_camera_back;
    } else if (lensDirection == CameraLensDirection.front) {
      return Icons.camera_front;
    }
    return Icons.camera;
  }
}
