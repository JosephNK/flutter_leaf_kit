import 'dart:ui';

class LeafRadioThemeData {
  final Color? activeColor;
  final Color? inactiveColor;

  const LeafRadioThemeData({this.activeColor, this.inactiveColor});

  LeafRadioThemeData copyWith({Color? activeColor, Color? inactiveColor}) {
    return LeafRadioThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }
}
