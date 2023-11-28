import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

extension QRCodeBarcodeFilter on List<Barcode> {
  List<Barcode> get textCodes => where((element) => element.type == BarcodeType.text).toList();

  Barcode? onQRCode() => textCodes.isEmpty ? null : textCodes.first;
  Barcode? onDataMatrix() => textCodes.isEmpty ? null : textCodes.first;
}
