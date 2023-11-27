import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SandboxFeature {
  camera,
  shimmer,
}

final showcaseFeturesProvider = Provider<List<SandboxFeature>>((ref) {
  return [SandboxFeature.camera, SandboxFeature.shimmer];
});
