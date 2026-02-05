import 'package:flutter/painting.dart';

/// Theme data for date/time picker V2 components.
class LFPickerThemeData {
  final Color? activeColor;
  final Color? backgroundColor;
  final TextStyle? headerTextStyle;

  const LFPickerThemeData({
    this.activeColor,
    this.backgroundColor,
    this.headerTextStyle,
  });

  LFPickerThemeData copyWith({
    Color? activeColor,
    Color? backgroundColor,
    TextStyle? headerTextStyle,
  }) {
    return LFPickerThemeData(
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    );
  }
}
