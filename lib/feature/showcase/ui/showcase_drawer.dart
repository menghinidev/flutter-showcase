import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/router/datamatrix/data_matrix_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/camera/ui/components/camera_ui_properties.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/shimmer/router/shimmer_showcase_route.dart';
import 'package:sandbox/feature/showcase/router/showcase_router.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';

import 'showcase_drawer_menu_item.dart';

class ShowcaseDrawer extends ConsumerWidget with CameraUIProperty {
  const ShowcaseDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ShowcaseDrawerMenuItem(
              title: 'QR Code',
              icon: cameraIcon,
              onTap: () => ref.read(showcaseRouterProvider).go(QrCodeScannerScreenRoute.fromHome()),
            ),
            divider,
            ShowcaseDrawerMenuItem(
              title: 'Data matrix',
              icon: cameraIcon,
              onTap: () => ref.read(showcaseRouterProvider).go(DataMatrixScannerScreenRoute.fromHome()),
            ),
            divider,
            ShowcaseDrawerMenuItem(
              title: 'Shimmer',
              icon: Icons.refresh,
              onTap: () => ref.read(showcaseRouterProvider).go(ShimmerScreenRoute.fromHome()),
            ),
            divider,
            ShowcaseDrawerMenuItem(
              title: 'Sliver',
              icon: Icons.list,
              onTap: () => ref.read(showcaseRouterProvider).go(SliverShowcaseRoute.fromHome()),
            ),
            divider,
            ShowcaseDrawerMenuItem(
              title: 'Pagination',
              icon: Icons.network_cell_outlined,
              onTap: () => ref.read(showcaseRouterProvider).go(PaginationShowcaseRoute.fromHome()),
            ),
          ],
        ),
      ),
    );
  }

  Widget get divider => const SizedBox(height: 16.0);
}
