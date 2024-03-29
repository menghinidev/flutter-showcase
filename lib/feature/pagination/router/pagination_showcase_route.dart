import 'package:go_router/go_router.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_page.dart';

class PaginationShowcaseRoute extends GoRoute {
  PaginationShowcaseRoute()
      : super(
          path: pageName,
          builder: (context, state) => const PaginationShowcasePage(),
        );
  static const pageName = 'pagination';
  static String fromHome() => '/$pageName';
}
