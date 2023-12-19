import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_scanner_showcase_screen.dart';

class QrCodeScannerScreenRoute extends GoRoute {
  static const String pagePath = 'scan/qr';
  static String fromHome() => '/$pagePath';
  QrCodeScannerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const QRCodeScannerShowcaseScreen(),
        );
}
