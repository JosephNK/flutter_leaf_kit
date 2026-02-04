import 'package:flutter/painting.dart';

class LFBottomSheetThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? itemTextStyle;
  final String? cancelText;

  const LFBottomSheetThemeData({
    this.activeColor,
    this.inactiveColor,
    this.itemTextStyle,
    this.cancelText,
  });

  LFBottomSheetThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
    TextStyle? itemTextStyle,
    String? cancelText,
  }) {
    return LFBottomSheetThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      cancelText: cancelText ?? this.cancelText,
    );
  }
}
