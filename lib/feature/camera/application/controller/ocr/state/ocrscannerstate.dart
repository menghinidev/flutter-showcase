import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocrscannerstate.freezed.dart';

@freezed
class OcrScannerState with _$OcrScannerState {
  factory OcrScannerState.cameraAquisition() = Initial;
  factory OcrScannerState.cropping({required File image}) = Cropping;
}
