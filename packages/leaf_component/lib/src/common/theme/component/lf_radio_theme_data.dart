import 'dart:ui';

class LFRadioThemeData {
  final Color? activeColor;
  final Color? inactiveColor;

  const LFRadioThemeData({
    this.activeColor,
    this.inactiveColor,
  });

  LFRadioThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return LFRadioThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }
}
