import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_route.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/showcase/router/showcase_router.dart';

import 'showcase_drawer.dart';
import 'showcase_list_item.dart';

class ShowcaseScreen extends ConsumerWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const ShowcaseDrawer(),
      appBar: AppBar(title: const Text('Showcase App')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ShowcaseListItem(
            title: 'Data matrix',
            onTap: () => ref.read(showcaseRouterProvider).go(DataMatrixScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Qr Code',
            onTap: () => ref.read(showcaseRouterProvider).go(QrCodeScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'OCR',
            onTap: () => ref.read(showcaseRouterProvider).go(OcrScannerScreenRoute.fromHome()),
          ),
          divider,
          ShowcaseListItem(
            title: 'Pagination',
            onTap: () => ref.read(showcaseRouterProvider).go(PaginationShowcaseRoute.fromHome()),
          ),
          divider,
          const ShowcaseListItem(title: 'Shimmer'),
        ],
      ),
    );
  }

  Widget get divider => const SizedBox(height: 16);
}
