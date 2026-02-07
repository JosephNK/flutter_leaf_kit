import 'package:flutter/painting.dart';

class LFAppBarThemeData {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? backButtonColor;
  final Color? bottomBorderColor;
  final Color? shadowColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final double? toolbarHeight;
  final double? actionsRightMargin;
  final TextStyle? titleStyle;

  const LFAppBarThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.backButtonColor,
    this.bottomBorderColor,
    this.shadowColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.toolbarHeight,
    this.actionsRightMargin,
    this.titleStyle,
  });

  LFAppBarThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? backButtonColor,
    Color? bottomBorderColor,
    Color? shadowColor,
    double? elevation,
    double? scrolledUnderElevation,
    double? toolbarHeight,
    double? actionsRightMargin,
    TextStyle? titleStyle,
  }) {
    return LFAppBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backButtonColor: backButtonColor ?? this.backButtonColor,
      bottomBorderColor: bottomBorderColor ?? this.bottomBorderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      actionsRightMargin: actionsRightMargin ?? this.actionsRightMargin,
      titleStyle: titleStyle ?? this.titleStyle,
    );
  }
}
