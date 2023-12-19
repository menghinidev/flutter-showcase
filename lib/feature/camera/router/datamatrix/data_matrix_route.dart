import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_scanner_showcase_screen.dart';

class DataMatrixScannerScreenRoute extends GoRoute {
  static const String pagePath = 'scan/datamatrix';
  static String fromHome() => '/$pagePath';
  DataMatrixScannerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const DataMatrixScannerShowcaseScreen(),
        );
}
