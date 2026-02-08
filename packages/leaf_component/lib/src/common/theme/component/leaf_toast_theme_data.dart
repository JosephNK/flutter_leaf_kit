import 'package:flutter/painting.dart';

class LeafToastThemeData {
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle? descriptionTextStyle;
  final BorderRadiusGeometry? borderRadius;

  const LeafToastThemeData({
    this.backgroundColor,
    this.textStyle,
    this.descriptionTextStyle,
    this.borderRadius,
  });

  LeafToastThemeData copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    TextStyle? descriptionTextStyle,
    BorderRadiusGeometry? borderRadius,
  }) {
    return LeafToastThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
