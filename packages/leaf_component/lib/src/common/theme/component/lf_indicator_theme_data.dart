import 'package:flutter/painting.dart';

class LFIndicatorThemeData {
  final EdgeInsets? padding;
  final double? strokeWidth;

  const LFIndicatorThemeData({
    this.padding,
    this.strokeWidth,
  });

  LFIndicatorThemeData copyWith({
    EdgeInsets? padding,
    double? strokeWidth,
  }) {
    return LFIndicatorThemeData(
      padding: padding ?? this.padding,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
