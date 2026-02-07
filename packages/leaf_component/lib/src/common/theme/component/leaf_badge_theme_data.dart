import 'package:flutter/painting.dart';

class LeafBadgeThemeData {
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? elevation;

  const LeafBadgeThemeData({
    this.size,
    this.backgroundColor,
    this.iconColor,
    this.textStyle,
    this.padding,
    this.elevation,
  });

  LeafBadgeThemeData copyWith({
    double? size,
    Color? backgroundColor,
    Color? iconColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    double? elevation,
  }) {
    return LeafBadgeThemeData(
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
    );
  }
}
