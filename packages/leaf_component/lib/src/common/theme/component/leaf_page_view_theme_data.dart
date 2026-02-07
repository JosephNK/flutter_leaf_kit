import 'package:flutter/painting.dart';

class LeafPageViewThemeData {
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;
  final Duration? autoPageDuration;
  final Duration? fadeTransitionDuration;

  const LeafPageViewThemeData({
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.autoPageDuration,
    this.fadeTransitionDuration,
  });

  LeafPageViewThemeData copyWith({
    Color? indicatorActiveColor,
    Color? indicatorInactiveColor,
    Duration? autoPageDuration,
    Duration? fadeTransitionDuration,
  }) {
    return LeafPageViewThemeData(
      indicatorActiveColor: indicatorActiveColor ?? this.indicatorActiveColor,
      indicatorInactiveColor:
          indicatorInactiveColor ?? this.indicatorInactiveColor,
      autoPageDuration: autoPageDuration ?? this.autoPageDuration,
      fadeTransitionDuration:
          fadeTransitionDuration ?? this.fadeTransitionDuration,
    );
  }
}
