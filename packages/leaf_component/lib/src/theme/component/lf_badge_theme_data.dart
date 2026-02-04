import 'package:flutter/painting.dart';

class LFBadgeThemeData {
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? elevation;

  const LFBadgeThemeData({
    this.size,
    this.backgroundColor,
    this.iconColor,
    this.textStyle,
    this.padding,
    this.elevation,
  });

  LFBadgeThemeData copyWith({
    double? size,
    Color? backgroundColor,
    Color? iconColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? elevation,
  }) {
    return LFBadgeThemeData(
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
    );
  }
}
