import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ShowcaseFeature {
  qrCodeScanner,
  dataMatrixScanner,
  shimmer,
  sliver,
}

final showcaseFeturesProvider = Provider<List<ShowcaseFeature>>((ref) {
  return [
    ShowcaseFeature.qrCodeScanner,
    ShowcaseFeature.dataMatrixScanner,
    ShowcaseFeature.shimmer,
    ShowcaseFeature.sliver,
  ];
});
