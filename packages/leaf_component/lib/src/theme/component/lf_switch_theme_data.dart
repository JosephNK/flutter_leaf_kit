import 'dart:ui';

class LFSwitchThemeData {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;

  const LFSwitchThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  LFSwitchThemeData copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return LFSwitchThemeData(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }
}
