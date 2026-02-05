import 'package:flutter/painting.dart';

/// Theme data for image V2 components (asset, cache, network, circle avatar).
class LFImageThemeData {
  final Color? placeholderColor;
  final Color? errorColor;
  final double? borderRadius;

  const LFImageThemeData({
    this.placeholderColor,
    this.errorColor,
    this.borderRadius,
  });

  LFImageThemeData copyWith({
    Color? placeholderColor,
    Color? errorColor,
    double? borderRadius,
  }) {
    return LFImageThemeData(
      placeholderColor: placeholderColor ?? this.placeholderColor,
      errorColor: errorColor ?? this.errorColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
