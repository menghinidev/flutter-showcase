import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/utils/router/showcase_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FlutterSandboxApp()));
}

class FlutterSandboxApp extends ConsumerWidget {
  const FlutterSandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(showcaseRouterProvider);
    return MaterialApp.router(
      theme: ThemeData.fallback(useMaterial3: true),
      showSemanticsDebugger: false,
      routerConfig: router,
    );
  }
}
