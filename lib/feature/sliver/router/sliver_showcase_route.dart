import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_screen.dart';

class SliverShowcaseRoute extends GoRoute {
  static const pageName = 'sliver';
  static String fromHome() => '/$pageName';

  SliverShowcaseRoute()
      : super(
          path: pageName,
          builder: (context, state) => const SliverShowcaseScreen(),
        );
}
