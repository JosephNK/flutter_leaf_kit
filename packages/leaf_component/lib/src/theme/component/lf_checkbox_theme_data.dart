import 'dart:ui';

class LFCheckBoxThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final double? runSpacing;

  const LFCheckBoxThemeData({
    this.activeColor,
    this.inactiveColor,
    this.runSpacing,
  });

  LFCheckBoxThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? runSpacing,
  }) {
    return LFCheckBoxThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      runSpacing: runSpacing ?? this.runSpacing,
    );
  }
}
