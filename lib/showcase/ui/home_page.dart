import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_route.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/shimmer/router/shimmer_showcase_route.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';
import 'package:sandbox/showcase/ui/showcase_list_item.dart';
import 'package:sandbox/utils/router/showcase_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Showcase App')),
      body: ListView(
        children: [
          ShowcaseListItem(
            title: 'Data matrix',
            onTap: () => ref.routerProvider.go(DataMatrixScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Qr Code',
            onTap: () => ref.routerProvider.go(QrCodeScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'OCR',
            onTap: () => ref.routerProvider.go(OcrScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Pagination',
            onTap: () => ref.routerProvider.go(PaginationShowcaseRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Shimmer',
            onTap: () => ref.routerProvider.go(ShimmerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Sliver',
            onTap: () => ref.routerProvider.go(SliverShowcaseRoute.fromHome()),
          ),
        ],
      ),
    );
  }

  Widget get divider => const SizedBox(height: 16);
}
