import 'package:flutter/painting.dart';

class LFNotificationThemeData {
  final Decoration? boxDecoration;
  final Duration? animationDuration;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final Color? iconColor;
  final double? iconSize;

  const LFNotificationThemeData({
    this.boxDecoration,
    this.animationDuration,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.iconColor,
    this.iconSize,
  });

  LFNotificationThemeData copyWith({
    Decoration? boxDecoration,
    Duration? animationDuration,
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    Color? iconColor,
    double? iconSize,
  }) {
    return LFNotificationThemeData(
      boxDecoration: boxDecoration ?? this.boxDecoration,
      animationDuration: animationDuration ?? this.animationDuration,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}
