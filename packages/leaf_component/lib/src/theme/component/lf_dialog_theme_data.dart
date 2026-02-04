import 'package:flutter/painting.dart';

class LFDialogThemeData {
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final TextStyle? cancelTextStyle;
  final Color? cancelTextBackgroundColor;
  final Color? cancelTextBorderColor;
  final EdgeInsets? cancelTextPadding;
  final BorderRadius? borderRadius;
  final String? okText;
  final String? cancelText;
  final String? errorMessageTitle;

  const LFDialogThemeData({
    this.titleStyle,
    this.messageStyle,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.cancelTextStyle,
    this.cancelTextBackgroundColor,
    this.cancelTextBorderColor,
    this.cancelTextPadding,
    this.borderRadius,
    this.okText,
    this.cancelText,
    this.errorMessageTitle,
  });

  LFDialogThemeData copyWith({
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    TextStyle? cancelTextStyle,
    Color? cancelTextBackgroundColor,
    Color? cancelTextBorderColor,
    EdgeInsets? cancelTextPadding,
    BorderRadius? borderRadius,
    String? okText,
    String? cancelText,
    String? errorMessageTitle,
  }) {
    return LFDialogThemeData(
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      okTextStyle: okTextStyle ?? this.okTextStyle,
      okTextBackgroundColor:
          okTextBackgroundColor ?? this.okTextBackgroundColor,
      okTextBorderColor: okTextBorderColor ?? this.okTextBorderColor,
      okTextPadding: okTextPadding ?? this.okTextPadding,
      cancelTextStyle: cancelTextStyle ?? this.cancelTextStyle,
      cancelTextBackgroundColor:
          cancelTextBackgroundColor ?? this.cancelTextBackgroundColor,
      cancelTextBorderColor:
          cancelTextBorderColor ?? this.cancelTextBorderColor,
      cancelTextPadding: cancelTextPadding ?? this.cancelTextPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      okText: okText ?? this.okText,
      cancelText: cancelText ?? this.cancelText,
      errorMessageTitle: errorMessageTitle ?? this.errorMessageTitle,
    );
  }
}
