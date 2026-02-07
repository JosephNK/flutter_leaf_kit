import 'package:flutter/painting.dart';

/// Theme data for date/time picker V2 components.
class LeafPickerThemeData {
  final Color? activeColor;
  final Color? backgroundColor;
  final TextStyle? headerTextStyle;

  const LeafPickerThemeData({
    this.activeColor,
    this.backgroundColor,
    this.headerTextStyle,
  });

  LeafPickerThemeData copyWith({
    Color? activeColor,
    Color? backgroundColor,
    TextStyle? headerTextStyle,
  }) {
    return LeafPickerThemeData(
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    );
  }
}
