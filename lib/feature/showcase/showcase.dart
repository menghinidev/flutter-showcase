import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/camera/application/barcode_extensions.dart';
import 'package:sandbox/feature/camera/router/data_matrix_scanner_showcase_screen.dart';

import '../camera/router/bottom_nav_bar_item.dart';
import '../camera/router/qr_code_scanner_showcase_screen.dart';
import '../shimmer/router/bottom_nav_bar_item.dart';
import '../shimmer/router/shimmer_showcase_screen.dart';
import 'features.dart';
import 'showcase_drawer.dart';

final showcasePageProvider = StateProvider<ShowcaseFeature>((ref) {
  return ShowcaseFeature.qrCodeScanner;
});

extension IndexFeature on StateController<ShowcaseFeature> {
  changeFromIndex(int index) {
    var newValue = ShowcaseFeature.values[index];
    state = newValue;
  }
}

class ShowcaseScreen extends ConsumerWidget {
  final qrDescription =
      "Inquadra il QR Code sul tuo bollettino CBILL/PagoPA all'interno dell'area evidenziata";
  final dataMatrixDescription =
      "Inquadra il Datamatrix sul tuo bollettino all'interno dell'area evidenziata";
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentFeature = ref.watch(showcasePageProvider);
    return Scaffold(
      drawer: const ShowcaseDrawer(),
      appBar: AppBar(title: const Text('Showcase App')),
      body: SafeArea(
        child: <Widget>[
          QRCodeScannerShowcaseScreen(
            description: qrDescription,
            onScanned: (value) {
              var content = value.rawValue;
              print('Code scanned: $content');
            },
            onManualInsert: () => print('Manual insert required'),
            onPermissionDenied: () {},
          ),
          DataMatrixScannerShowcaseScreen(
            description: dataMatrixDescription,
            onScanned: (value) {
              var content = value.rawValue;
              print('Code scanned: $content');
              value.getDatamatrixPayload();
            },
            onManualInsert: () => print('Manual insert required'),
            onPermissionDenied: () {},
          ),
          const ShimmerShowcaseScreen(),
        ][currentFeature.index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentFeature.index,
        onTap: (index) =>
            ref.read(showcasePageProvider.notifier).changeFromIndex(index),
        items: [
          QRCodeScannerRouteNavigationItem(),
          DataMatrixScannerRouteNavigationItem(),
          sandboxShimmerRouteNavigationItem(),
        ],
      ),
    );
  }
}
