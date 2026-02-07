import 'package:flutter/painting.dart';

class LeafTextFieldThemeData {
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? placeholderColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? clearIconColor;
  final Color? disabledClearIconColor;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final double? borderWidth;
  final TextStyle? countTextStyle;
  final TextStyle? errorTextStyle;

  const LeafTextFieldThemeData({
    this.textStyle,
    this.textColor,
    this.disabledTextColor,
    this.placeholderColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.clearIconColor,
    this.disabledClearIconColor,
    this.contentPadding,
    this.borderRadius,
    this.borderWidth,
    this.countTextStyle,
    this.errorTextStyle,
  });

  LeafTextFieldThemeData copyWith({
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    Color? placeholderColor,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? borderColor,
    Color? focusBorderColor,
    Color? errorBorderColor,
    Color? clearIconColor,
    Color? disabledClearIconColor,
    EdgeInsets? contentPadding,
    double? borderRadius,
    double? borderWidth,
    TextStyle? countTextStyle,
    TextStyle? errorTextStyle,
  }) {
    return LeafTextFieldThemeData(
      textStyle: textStyle ?? this.textStyle,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      clearIconColor: clearIconColor ?? this.clearIconColor,
      disabledClearIconColor:
          disabledClearIconColor ?? this.disabledClearIconColor,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      countTextStyle: countTextStyle ?? this.countTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
    );
  }
}
