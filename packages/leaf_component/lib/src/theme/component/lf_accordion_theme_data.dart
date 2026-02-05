import 'package:flutter/painting.dart';

/// Theme data for the accordion V2 component.
class LFAccordionThemeData {
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final Color? dividerColor;
  final Color? iconColor;

  const LFAccordionThemeData({
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.dividerColor,
    this.iconColor,
  });

  LFAccordionThemeData copyWith({
    Color? headerBackgroundColor,
    Color? contentBackgroundColor,
    Color? dividerColor,
    Color? iconColor,
  }) {
    return LFAccordionThemeData(
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      contentBackgroundColor:
          contentBackgroundColor ?? this.contentBackgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
