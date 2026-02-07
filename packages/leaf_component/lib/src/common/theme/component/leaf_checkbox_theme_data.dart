import 'dart:ui';

class LeafCheckBoxThemeData {
  final Color? activeColor;
  final Color? inactiveColor;
  final double? runSpacing;

  const LeafCheckBoxThemeData({
    this.activeColor,
    this.inactiveColor,
    this.runSpacing,
  });

  LeafCheckBoxThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? runSpacing,
  }) {
    return LeafCheckBoxThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      runSpacing: runSpacing ?? this.runSpacing,
    );
  }
}
