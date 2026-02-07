import 'package:flutter/painting.dart';

/// Theme data for the accordion V2 component.
class LeafAccordionThemeData {
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final Color? dividerColor;
  final Color? iconColor;

  const LeafAccordionThemeData({
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.dividerColor,
    this.iconColor,
  });

  LeafAccordionThemeData copyWith({
    Color? headerBackgroundColor,
    Color? contentBackgroundColor,
    Color? dividerColor,
    Color? iconColor,
  }) {
    return LeafAccordionThemeData(
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      contentBackgroundColor:
          contentBackgroundColor ?? this.contentBackgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
