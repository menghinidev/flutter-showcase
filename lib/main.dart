import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/ui/theme/app_theme.dart';
import 'package:sandbox/utils/env.dart';
import 'package:sandbox/utils/router/showcase_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options
        ..dsn = FlutterShowcaseEnv.sentryApiKey
        ..environment = FlutterShowcaseEnv.env
        ..tracesSampleRate = 1.0;
    },
    appRunner: () {
      WidgetsFlutterBinding.ensureInitialized();
      SemanticsBinding.instance.ensureSemantics();
      runApp(
        ProviderScope(
          child: DefaultAssetBundle(
            bundle: SentryAssetBundle(),
            child: const FlutterSandboxApp(),
          ),
        ),
      );
    },
  );
}

class FlutterSandboxApp extends ConsumerWidget {
  const FlutterSandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(showcaseRouterProvider);
    final appTheme = ref.watch(appThemeProvider);
    return MaterialApp.router(
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('it'), // Italian
      ],
    );
  }
}
