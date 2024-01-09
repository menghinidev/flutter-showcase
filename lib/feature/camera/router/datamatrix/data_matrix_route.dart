import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_scanner_showcase_page.dart';

class DataMatrixScannerScreenRoute extends GoRoute {
  DataMatrixScannerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const DataMatrixScannerShowcasePage(),
        );
  static const String pagePath = 'scan/datamatrix';
  static String fromHome() => '/$pagePath';
}
