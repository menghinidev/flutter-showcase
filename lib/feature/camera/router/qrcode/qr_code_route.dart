import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_scanner_showcase_page.dart';

class QrCodeScannerScreenRoute extends GoRoute {
  QrCodeScannerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const QRCodeScannerShowcasePage(),
        );
  static const String pagePath = 'scan/qr';
  static String fromHome() => '/$pagePath';
}
