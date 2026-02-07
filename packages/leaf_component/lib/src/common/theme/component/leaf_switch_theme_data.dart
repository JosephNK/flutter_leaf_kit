import 'dart:ui';

class LeafSwitchThemeData {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;

  const LeafSwitchThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  LeafSwitchThemeData copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return LeafSwitchThemeData(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }
}
