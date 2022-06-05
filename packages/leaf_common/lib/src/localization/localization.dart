import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LeafLocalization {
  static Future<void> ensureInitialized() async =>
      await EasyLocalization.ensureInitialized();

  static Widget initialized({
    required List<Locale> supportedLocales,
    required String path,
    required Locale? fallbackLocale,
    required Widget child,
  }) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: path,
      fallbackLocale: fallbackLocale,
      child: child,
    );
  }
}
