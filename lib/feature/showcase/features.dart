import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ShowcaseFeature {
  camera,
  shimmer,
}

final showcaseFeturesProvider = Provider<List<ShowcaseFeature>>((ref) {
  return [ShowcaseFeature.camera, ShowcaseFeature.shimmer];
});
