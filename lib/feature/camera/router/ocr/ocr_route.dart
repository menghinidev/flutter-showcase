import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_showcase_page.dart';

class OcrScannerScreenRoute extends GoRoute {
  static const String pagePath = 'scan/ocr';
  static String fromHome() => '/$pagePath';
  OcrScannerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const OcrShowcasePage(),
        );
}
