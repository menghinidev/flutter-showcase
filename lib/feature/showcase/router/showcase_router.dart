import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_route.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/shimmer/router/shimmer_showcase_route.dart';
import 'package:sandbox/feature/showcase/ui/showcase.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final showcaseRouterProvider = Provider<GoRouter>((ref) {
  final key = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: key,
    routes: [HomeShowcaseRoute()],
  );
});

class HomeShowcaseRoute extends GoRoute {
  HomeShowcaseRoute()
      : super(
          path: '/',
          builder: (context, state) => const ShowcaseScreen(),
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
