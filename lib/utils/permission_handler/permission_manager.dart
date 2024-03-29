import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManagerProvider = Provider<PermissionManager>((ref) {
  return PermissionManager();
});

class PermissionManager {
  Future<bool> askForCameraAccess() async {
    final status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) return true;
    return false;
  }

  Future<bool> askForMicrophoneAccess() async {
    final status = await Permission.microphone.request();
    if (status.isGranted || status.isLimited) return true;
    return false;
  }
}
