import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_route.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/shimmer/router/shimmer_showcase_route.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';
import 'package:sandbox/showcase/ui/home/home_page.dart';

class HomeShowcaseRoute extends GoRoute {
  HomeShowcaseRoute()
      : super(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            SliverShowcaseRoute(),
            PaginationShowcaseRoute(),
            ShimmerScreenRoute(),
            QrCodeScannerScreenRoute(),
            DataMatrixScannerScreenRoute(),
            OcrScannerScreenRoute(),
          ],
        );
}
