import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/application/controller/ocr/state/ocrscannerstate.dart';
import 'package:sandbox/feature/camera/application/mlkit_controller.dart';
import 'package:sandbox/utils/dialog/dialog_manager.dart';

final ocrScannerControllerProvider =
    StateNotifierProvider<OcrScannerScreenController, AsyncValue<OcrScannerState>>((ref) {
  final dialogManager = ref.read(dialogManagerProvider);
  final mlkitManager = ref.read(mlkitControllerProvider);
  return OcrScannerScreenController(
    dialogManager: dialogManager,
    mlkitController: mlkitManager,
  );
});

class OcrScannerScreenController extends StateNotifier<AsyncValue<OcrScannerState>> {
  OcrScannerScreenController({
    required this.mlkitController,
    required this.dialogManager,
  }) : super(AsyncData(OcrScannerState.cameraAquisition()));

  final MlKitController mlkitController;
  final DialogManager dialogManager;

  Future<void> takePicture(CameraController controller) async {
    final actualState = state.mapOrNull(data: (data) => data.valueOrNull);
    if (actualState == null) return Future.value();
    state = const AsyncLoading();
    try {
      final pic = await controller.takePicture();
      state = AsyncData(OcrScannerState.cropping(image: File(pic.path)));
    } catch (e) {
      state = AsyncData(OcrScannerState.cameraAquisition());
      log(e.toString());
    }
    return Future.value();
  }

  Future<void> submitImage() async {
    final file = state.mapOrNull(data: (data) => data.valueOrNull?.mapOrNull(cropping: (data) => data.image));
    if (file == null) return Future.value();
    state = const AsyncLoading();
    try {
      final xFile = XFile(file.path);
      final image = mlkitController.fromFile(xFile);
      final response = await mlkitController.scanOCR(image);
      final iban = _findIban(response);
      if (iban != null) {
        await dialogManager.showSuccessDialog<void>(text: 'IBAN riconosciuto: $iban');
      } else {
        await dialogManager.showSuccessDialog<void>(text: 'IBAN non riconosciuto\nValore: $response');
      }
    } catch (e) {
      log(e.toString());
    }
    state = AsyncData(OcrScannerState.cameraAquisition());
  }

  String? _findIban(String result) {
    if (result.isEmpty) return null;
    final regex = RegExp('([A-Z]{2}[0-9]{2})[A-Z0-9]{23}');
    final normalized = result.trim().replaceAll('\n', '').replaceAll(' ', '').replaceAll('-', '').replaceAll('O', '0');
    log('Normalized: $normalized');
    return regex.stringMatch(normalized);
  }
}
