import 'package:flutter/painting.dart';

/// Theme data for the bottom navigation bar V2 component.
class LFNavigationBarThemeData {
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? labelStyle;

  const LFNavigationBarThemeData({
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
  });

  LFNavigationBarThemeData copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? labelStyle,
  }) {
    return LFNavigationBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }
}
