import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeProvider = Provider<AppTheme>((ref) {
  return AppTheme();
});

class AppTheme {
  ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.bahamaBlue,
        useMaterial3: true,
      );
  ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.aquaBlue,
        useMaterial3: true,
      );
}
