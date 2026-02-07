import 'package:flutter/painting.dart';

class LFPageViewThemeData {
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;
  final Duration? autoPageDuration;
  final Duration? fadeTransitionDuration;

  const LFPageViewThemeData({
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.autoPageDuration,
    this.fadeTransitionDuration,
  });

  LFPageViewThemeData copyWith({
    Color? indicatorActiveColor,
    Color? indicatorInactiveColor,
    Duration? autoPageDuration,
    Duration? fadeTransitionDuration,
  }) {
    return LFPageViewThemeData(
      indicatorActiveColor: indicatorActiveColor ?? this.indicatorActiveColor,
      indicatorInactiveColor:
          indicatorInactiveColor ?? this.indicatorInactiveColor,
      autoPageDuration: autoPageDuration ?? this.autoPageDuration,
      fadeTransitionDuration:
          fadeTransitionDuration ?? this.fadeTransitionDuration,
    );
  }
}
