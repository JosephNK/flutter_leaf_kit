import 'package:flutter/painting.dart';

class LFButtonThemeData {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final double? leadingSpacing;

  const LFButtonThemeData({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.leadingSpacing,
  });

  LFButtonThemeData copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    double? leadingSpacing,
  }) {
    return LFButtonThemeData(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      padding: padding ?? this.padding,
      leadingSpacing: leadingSpacing ?? this.leadingSpacing,
    );
  }
}
