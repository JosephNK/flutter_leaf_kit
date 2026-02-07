import 'package:flutter/painting.dart';

/// Theme data for the rating bar V2 component.
class LeafRatingBarThemeData {
  final Color? ratedColor;
  final Color? unratedColor;
  final double? size;
  final double? spacing;

  const LeafRatingBarThemeData({
    this.ratedColor,
    this.unratedColor,
    this.size,
    this.spacing,
  });

  LeafRatingBarThemeData copyWith({
    Color? ratedColor,
    Color? unratedColor,
    double? size,
    double? spacing,
  }) {
    return LeafRatingBarThemeData(
      ratedColor: ratedColor ?? this.ratedColor,
      unratedColor: unratedColor ?? this.unratedColor,
      size: size ?? this.size,
      spacing: spacing ?? this.spacing,
    );
  }
}
