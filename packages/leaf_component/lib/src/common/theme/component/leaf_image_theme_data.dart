import 'package:flutter/painting.dart';

/// Theme data for image V2 components (asset, cache, network, circle avatar).
class LeafImageThemeData {
  final Color? placeholderColor;
  final Color? errorColor;
  final double? borderRadius;

  const LeafImageThemeData({
    this.placeholderColor,
    this.errorColor,
    this.borderRadius,
  });

  LeafImageThemeData copyWith({
    Color? placeholderColor,
    Color? errorColor,
    double? borderRadius,
  }) {
    return LeafImageThemeData(
      placeholderColor: placeholderColor ?? this.placeholderColor,
      errorColor: errorColor ?? this.errorColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
