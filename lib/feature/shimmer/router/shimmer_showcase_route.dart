import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/shimmer/router/shimmer_showcase_page.dart';

class ShimmerScreenRoute extends GoRoute {
  static const String pagePath = 'shimmer';
  static String fromHome() => '/$pagePath';
  ShimmerScreenRoute()
      : super(
          path: pagePath,
          builder: (context, state) => const ShimmerShowcasePage(),
        );
}
