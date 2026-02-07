import 'package:flutter/painting.dart';

class LeafChipThemeData {
  final Color? defaultColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final double? borderRadius;

  const LeafChipThemeData({
    this.defaultColor,
    this.selectedColor,
    this.padding,
    this.borderRadius,
  });

  LeafChipThemeData copyWith({
    Color? defaultColor,
    Color? selectedColor,
    EdgeInsets? padding,
    double? borderRadius,
  }) {
    return LeafChipThemeData(
      defaultColor: defaultColor ?? this.defaultColor,
      selectedColor: selectedColor ?? this.selectedColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
