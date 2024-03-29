import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/router/showcase_router.dart';
import 'package:sandbox/utils/env.dart';
import 'package:sandbox/utils/logger/logger_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final showcaseRouterProvider = Provider<GoRouter>((ref) {
  final key = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: key,
    observers: [
      if (kDebugMode)
        LoggerNavigatorObserver(
          logger: ref.read(loggerManagerProvider),
        ),
      if (FlutterShowcaseEnv.env != 'Dev') SentryNavigatorObserver(),
    ],
    routes: [HomeShowcaseRoute()],
  );
});

extension GoRouterProvider on WidgetRef {
  GoRouter get routerProvider => read(showcaseRouterProvider);
}

class LoggerNavigatorObserver extends NavigatorObserver {
  LoggerNavigatorObserver({required this.logger});

  final LoggerManager logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.logMessage('Route pushed: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }
}
