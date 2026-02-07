import 'package:flutter/painting.dart';

class LeafIndicatorThemeData {
  final EdgeInsets? padding;
  final double? strokeWidth;

  const LeafIndicatorThemeData({
    this.padding,
    this.strokeWidth,
  });

  LeafIndicatorThemeData copyWith({
    EdgeInsets? padding,
    double? strokeWidth,
  }) {
    return LeafIndicatorThemeData(
      padding: padding ?? this.padding,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
