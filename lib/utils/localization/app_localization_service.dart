import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  // 1. initialize from the initial locale
  const itaLocale = Locale('it');
  ref.state = lookupAppLocalizations(itaLocale);
  // 2. create an observer to update the state
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(itaLocale);
  });
  // 3. register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  // 4. return the state
  return ref.state;
});

class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
