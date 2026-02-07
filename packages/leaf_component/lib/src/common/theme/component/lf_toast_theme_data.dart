import 'package:flutter/painting.dart';

class LFToastThemeData {
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle? descriptionTextStyle;
  final BorderRadiusGeometry? borderRadius;

  const LFToastThemeData({
    this.backgroundColor,
    this.textStyle,
    this.descriptionTextStyle,
    this.borderRadius,
  });

  LFToastThemeData copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    TextStyle? descriptionTextStyle,
    BorderRadiusGeometry? borderRadius,
  }) {
    return LFToastThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      descriptionTextStyle:
          descriptionTextStyle ?? this.descriptionTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
