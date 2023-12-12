import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/showcase/router/showcase_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SandboxApp()));
}

class SandboxApp extends ConsumerWidget {
  const SandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(showcaseRouterProvider);
    return MaterialApp.router(
      theme: ThemeData.fallback(useMaterial3: true),
      routerConfig: router,
    );
  }
}
