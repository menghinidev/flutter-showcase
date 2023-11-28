import 'package:flutter/material.dart';

class QRCodeScannerRouteNavigationItem extends BottomNavigationBarItem {
  QRCodeScannerRouteNavigationItem()
      : super(
          icon: const Icon(Icons.qr_code),
          label: 'QR Code',
        );
}

class DataMatrixScannerRouteNavigationItem extends BottomNavigationBarItem {
  DataMatrixScannerRouteNavigationItem()
      : super(
          icon: const Icon(Icons.scanner),
          label: 'Data matrix',
        );
}
