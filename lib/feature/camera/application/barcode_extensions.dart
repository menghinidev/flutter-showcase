import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

extension QRCodeBarcodeFilter on List<Barcode> {
  List<Barcode> get textCodes => where((element) => element.type == BarcodeType.text).toList();

  Barcode? onQRCode() => textCodes.isEmpty ? null : textCodes.first;
  Barcode? onDataMatrix() => textCodes.isEmpty ? null : textCodes.first;
}

extension BarcodeParser on Barcode {
  List<String>? getDatamatrixPayload() {
    final splitBarcode = <String>[];
    final dataMatrix = rawValue ?? '';
    if (dataMatrix.isNotEmpty) {
      const nCp = 2;
      const nCodBol = 1;
      final postalCodeEnd = __getPostalCodeEnd(dataMatrix, nCp: nCp);
      if (postalCodeEnd == null) return null;
      final postalCode = _getPostalCode(dataMatrix, nCp: nCp);
      if (postalCode != null) splitBarcode.add(postalCode);
      final accreditoEnd = __getCCAccreditoEnd(
        dataMatrix,
        nCp: nCp,
        postalCodeEnd: postalCodeEnd,
      );
      if (accreditoEnd == null) return null;
      final cc = _getCCAccredito(
        dataMatrix,
        postalCodeEnd: postalCodeEnd,
        nCp: nCp,
      );
      if (cc != null) splitBarcode.add(cc);
      final amountEnd = __getAmountEnd(
        dataMatrix,
        nCp: nCp,
        ccAccreditoEnd: accreditoEnd,
      );
      if (amountEnd == null) return null;
      final amount = _getAmount(
        dataMatrix,
        ccAccreditoEnd: accreditoEnd,
        nCp: nCp,
      );
      if (amount != null) splitBarcode.add(amount);
      final bollettinoCode = _getBollettino(
        dataMatrix,
        nCodBol: nCodBol,
        nCp: nCp,
        amountEnd: amountEnd,
      );
      if (bollettinoCode != null) splitBarcode.add(bollettinoCode);
    }
    return splitBarcode;
  }

  int? __getPostalCodeEnd(String value, {required int nCp}) {
    final postalCodeLengthString = value.substring(0, nCp);
    final postalCodeLength = int.tryParse(postalCodeLengthString);
    if (postalCodeLength == null) return null;
    return nCp + postalCodeLength;
  }

  String? _getPostalCode(String value, {required int nCp}) {
    final postalCodeEnd = __getPostalCodeEnd(value, nCp: nCp);
    if (postalCodeEnd == null) return null;
    if (value.length < postalCodeEnd) return null;
    return value.substring(
      nCp,
      postalCodeEnd,
    );
  }

  int? __getCCAccreditoEnd(
    String value, {
    required int nCp,
    required int postalCodeEnd,
  }) {
    final ccAccreditoLengthString = value.substring(
      postalCodeEnd,
      postalCodeEnd + nCp,
    );
    final ccAccreditoLength = int.tryParse(ccAccreditoLengthString);
    if (ccAccreditoLength == null) return null;
    return postalCodeEnd + nCp + ccAccreditoLength;
  }

  String? _getCCAccredito(
    String value, {
    required int postalCodeEnd,
    required int nCp,
  }) {
    final ccAccreditoEnd = __getCCAccreditoEnd(
      value,
      nCp: nCp,
      postalCodeEnd: postalCodeEnd,
    );
    if (ccAccreditoEnd == null) return null;
    if (value.length < ccAccreditoEnd) return null;
    return value.substring(
      postalCodeEnd + nCp,
      ccAccreditoEnd,
    );
  }

  int? __getAmountEnd(
    String value, {
    required int nCp,
    required int ccAccreditoEnd,
  }) {
    final amountLengthString = value.substring(
      ccAccreditoEnd,
      ccAccreditoEnd + nCp,
    );
    final amountLength = int.tryParse(amountLengthString);
    if (amountLength == null) return null;
    return ccAccreditoEnd + nCp + amountLength;
  }

  String? _getAmount(
    String value, {
    required int ccAccreditoEnd,
    required int nCp,
  }) {
    const nDecimal = 2;
    final amountEnd = __getAmountEnd(
      value,
      nCp: nCp,
      ccAccreditoEnd: ccAccreditoEnd,
    );
    final amountString = value.substring(
      ccAccreditoEnd + nCp,
      amountEnd,
    );
    if (amountString.isEmpty) return null;
    final decimalAmountString = amountString.substring(
      amountString.length - nDecimal,
      amountString.length,
    );
    final mainAmount = amountString.substring(
      0,
      amountString.length - nDecimal,
    );
    return '$mainAmount.$decimalAmountString';
  }

  int? __getBollettinoEnd(
    String value, {
    required int nCp,
    required int nCodBol,
    required int amountEnd,
  }) {
    final bollettinoCodeLengthString = value.substring(
      amountEnd,
      amountEnd + nCodBol,
    );
    final codiceBollettinoLength = int.tryParse(bollettinoCodeLengthString);
    if (codiceBollettinoLength == null) return null;
    if (value.length < amountEnd + nCodBol) {
      return null;
    }
    return amountEnd + nCodBol + codiceBollettinoLength;
  }

  String? _getBollettino(
    String value, {
    required int nCodBol,
    required int nCp,
    required int amountEnd,
  }) {
    final bollettinoEnd = __getBollettinoEnd(
      value,
      nCp: nCp,
      nCodBol: nCodBol,
      amountEnd: amountEnd,
    );
    return value.substring(
      amountEnd + nCodBol,
      bollettinoEnd,
    );
  }
}
