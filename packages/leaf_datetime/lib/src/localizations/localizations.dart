import 'package:flutter/material.dart';

import 'localization/lf_localization.dart';

class LFLocalizations {
  static final LFLocalizations _instance = LFLocalizations._internal();
  static LFLocalizations get shared => _instance;
  LFLocalizations._internal();

  late LFLocalization _localization;
  late Locale _locale;
  late String _languageCode;

  LFLocalization get localization => LFLocalizations.shared._localization;

  Locale get locale => LFLocalizations.shared._locale;

  String get languageCode => LFLocalizations.shared._languageCode;

  void config(
    BuildContext context, {
    required Locale locale,
  }) {
    _locale = locale;

    try {
      _languageCode = _locale.languageCode;
      if (_languageCode == 'ko') {
        _localization = LFLocalizationKo();
      } else {
        _localization = LFLocalizationEn();
      }
    } catch (e) {
      debugPrint('LFLocalization Locale error: $e');
      _localization = LFLocalizationEn();
    }
  }
}
