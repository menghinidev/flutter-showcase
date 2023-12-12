import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManagerProvider = Provider<PermissionManager>((ref) {
  return PermissionManager();
});

class PermissionManager {
  Future<bool> askForCameraAccess() async {
    var status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) return true;
    return false;
  }

  Future<bool> askForMicrophoneAccess() async {
    var status = await Permission.microphone.request();
    if (status.isGranted || status.isLimited) return true;
    return false;
  }
}
