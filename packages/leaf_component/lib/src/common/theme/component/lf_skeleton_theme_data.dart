import 'dart:ui';

class LFSkeletonThemeData {
  final Color? baseColor;
  final Color? highlightColor;
  final double? baseOpacity;
  final double? highlightOpacity;
  final double? radius;

  const LFSkeletonThemeData({
    this.baseColor,
    this.highlightColor,
    this.baseOpacity,
    this.highlightOpacity,
    this.radius,
  });

  LFSkeletonThemeData copyWith({
    Color? baseColor,
    Color? highlightColor,
    double? baseOpacity,
    double? highlightOpacity,
    double? radius,
  }) {
    return LFSkeletonThemeData(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      baseOpacity: baseOpacity ?? this.baseOpacity,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      radius: radius ?? this.radius,
    );
  }
}
