import 'package:flutter/painting.dart';

class LeafTabBarThemeData {
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? indicatorColor;
  final Color? dividerColor;
  final EdgeInsets? indicatorPadding;
  final EdgeInsets? labelPadding;

  const LeafTabBarThemeData({
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorColor,
    this.dividerColor,
    this.indicatorPadding,
    this.labelPadding,
  });

  LeafTabBarThemeData copyWith({
    Color? labelColor,
    Color? unselectedLabelColor,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    Color? indicatorColor,
    Color? dividerColor,
    EdgeInsets? indicatorPadding,
    EdgeInsets? labelPadding,
  }) {
    return LeafTabBarThemeData(
      labelColor: labelColor ?? this.labelColor,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
      labelStyle: labelStyle ?? this.labelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      dividerColor: dividerColor ?? this.dividerColor,
      indicatorPadding: indicatorPadding ?? this.indicatorPadding,
      labelPadding: labelPadding ?? this.labelPadding,
    );
  }
}
