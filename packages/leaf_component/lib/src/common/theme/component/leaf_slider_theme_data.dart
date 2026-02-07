import 'package:flutter/painting.dart';

/// Theme data for slider and range-slider V2 components.
class LeafSliderThemeData {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;

  const LeafSliderThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  LeafSliderThemeData copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return LeafSliderThemeData(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }
}
