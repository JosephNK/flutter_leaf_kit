import 'package:flutter/painting.dart';

/// Theme data for slider and range-slider V2 components.
class LFSliderThemeData {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;

  const LFSliderThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  LFSliderThemeData copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return LFSliderThemeData(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }
}
