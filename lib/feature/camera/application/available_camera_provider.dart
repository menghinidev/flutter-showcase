import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availableCamerasProvider = FutureProvider<List<CameraDescription>>((ref) async {
  var cameras = await availableCameras();
  return cameras;
});

final currentCameraProvider = StateProvider<CameraDescription?>((ref) {
  var availableCameras = ref.watch(availableCamerasProvider);
  return availableCameras.whenOrNull(data: (data) => data.isEmpty ? null : data.first);
});
