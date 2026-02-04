import 'package:flutter/widgets.dart';

import 'lf_theme_data.dart';

class LFTheme extends InheritedWidget {
  final LFThemeData data;

  const LFTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static LFThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<LFTheme>();
    return theme?.data ?? LFThemeData.light();
  }

  static LFThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LFTheme>()?.data;
  }

  @override
  bool updateShouldNotify(LFTheme oldWidget) => data != oldWidget.data;
}
