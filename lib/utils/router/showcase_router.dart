import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/router/showcase_router.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final showcaseRouterProvider = Provider<GoRouter>((ref) {
  final key = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: key,
    routes: [HomeShowcaseRoute()],
  );
});

extension GoRouterProvider on WidgetRef {
  GoRouter get routerProvider => read(showcaseRouterProvider);
}
