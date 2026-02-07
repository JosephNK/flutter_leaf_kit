import 'package:flutter/painting.dart';

class LeafCalendarThemeData {
  final Color? todayColor;
  final Color? selectedColor;
  final Color? holidayColor;
  final TextStyle? dayTextStyle;
  final String? okText;

  const LeafCalendarThemeData({
    this.todayColor,
    this.selectedColor,
    this.holidayColor,
    this.dayTextStyle,
    this.okText,
  });

  LeafCalendarThemeData copyWith({
    Color? todayColor,
    Color? selectedColor,
    Color? holidayColor,
    TextStyle? dayTextStyle,
    String? okText,
  }) {
    return LeafCalendarThemeData(
      todayColor: todayColor ?? this.todayColor,
      selectedColor: selectedColor ?? this.selectedColor,
      holidayColor: holidayColor ?? this.holidayColor,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      okText: okText ?? this.okText,
    );
  }
}
