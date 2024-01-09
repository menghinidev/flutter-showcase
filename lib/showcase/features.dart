import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ShowcaseFeature {
  qrCodeScanner,
  dataMatrixScanner,
  shimmer,
  sliver,
  pagination,
  ocr,
}

final showcaseFeturesProvider = Provider<List<ShowcaseFeature>>((ref) {
  return [
    ShowcaseFeature.qrCodeScanner,
    ShowcaseFeature.dataMatrixScanner,
    ShowcaseFeature.shimmer,
    ShowcaseFeature.sliver,
    ShowcaseFeature.pagination,
  ];
});
