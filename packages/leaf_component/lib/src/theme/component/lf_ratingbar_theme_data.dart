import 'package:flutter/painting.dart';

/// Theme data for the rating bar V2 component.
class LFRatingBarThemeData {
  final Color? ratedColor;
  final Color? unratedColor;
  final double? size;
  final double? spacing;

  const LFRatingBarThemeData({
    this.ratedColor,
    this.unratedColor,
    this.size,
    this.spacing,
  });

  LFRatingBarThemeData copyWith({
    Color? ratedColor,
    Color? unratedColor,
    double? size,
    double? spacing,
  }) {
    return LFRatingBarThemeData(
      ratedColor: ratedColor ?? this.ratedColor,
      unratedColor: unratedColor ?? this.unratedColor,
      size: size ?? this.size,
      spacing: spacing ?? this.spacing,
    );
  }
}
