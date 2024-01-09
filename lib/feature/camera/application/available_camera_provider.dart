import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final availableCamerasProvider = FutureProvider<List<CameraDescription>>((ref) async {
  final cameras = await availableCameras();
  return cameras;
});

final currentCameraProvider = StateProvider<CameraDescription?>((ref) {
  final availableCameras = ref.watch(availableCamerasProvider);
  return availableCameras.whenOrNull(data: (data) => data.isEmpty ? null : data.first);
});
