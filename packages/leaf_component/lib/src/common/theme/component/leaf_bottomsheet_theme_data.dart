import 'package:flutter/painting.dart';

class LeafBottomSheetThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? itemTextStyle;
  final String? cancelText;

  const LeafBottomSheetThemeData({
    this.activeColor,
    this.inactiveColor,
    this.itemTextStyle,
    this.cancelText,
  });

  LeafBottomSheetThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
    TextStyle? itemTextStyle,
    String? cancelText,
  }) {
    return LeafBottomSheetThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      cancelText: cancelText ?? this.cancelText,
    );
  }
}
