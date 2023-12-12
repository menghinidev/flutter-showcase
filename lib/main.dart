import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/feature/showcase/showcase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FlutterSandboxApp()));
}

class FlutterSandboxApp extends ConsumerWidget {
  const FlutterSandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData.fallback(useMaterial3: true),
      home: const ShowcaseScreen(),
    );
  }
}
