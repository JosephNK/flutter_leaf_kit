import 'package:flutter/painting.dart';

class LFChipThemeData {
  final Color? defaultColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final double? borderRadius;

  const LFChipThemeData({
    this.defaultColor,
    this.selectedColor,
    this.padding,
    this.borderRadius,
  });

  LFChipThemeData copyWith({
    Color? defaultColor,
    Color? selectedColor,
    EdgeInsets? padding,
    double? borderRadius,
  }) {
    return LFChipThemeData(
      defaultColor: defaultColor ?? this.defaultColor,
      selectedColor: selectedColor ?? this.selectedColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
