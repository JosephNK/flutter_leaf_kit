import 'package:flutter/widgets.dart';

import 'leaf_theme_data.dart';

class LeafTheme extends InheritedWidget {
  final LeafThemeData data;

  const LeafTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static LeafThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<LeafTheme>();
    return theme?.data ?? LeafThemeData.light();
  }

  static LeafThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LeafTheme>()?.data;
  }

  @override
  bool updateShouldNotify(LeafTheme oldWidget) => data != oldWidget.data;
}
