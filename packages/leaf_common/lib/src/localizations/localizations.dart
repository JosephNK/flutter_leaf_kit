import 'package:flutter/material.dart';

import 'localization/leaf_localization.dart';

class LeafLocalizations {
  static final LeafLocalizations _instance = LeafLocalizations._internal();
  static LeafLocalizations get shared => _instance;
  LeafLocalizations._internal();

  late LeafLocalization _localization;
  late Locale _locale;
  late String _languageCode;

  LeafLocalization get localization => LeafLocalizations.shared._localization;

  Locale get locale => LeafLocalizations.shared._locale;

  String get languageCode => LeafLocalizations.shared._languageCode;

  void config(
    BuildContext context, {
    required Locale locale,
  }) {
    _locale = locale;

    try {
      _languageCode = _locale.languageCode;
      if (_languageCode == 'ko') {
        _localization = LeafLocalizationKo();
      } else {
        _localization = LeafLocalizationEn();
      }
    } catch (e) {
      debugPrint('LeafLocalization Locale error: $e');
      _localization = LeafLocalizationEn();
    }
  }
}
