import 'dart:ui';

class LeafSkeletonThemeData {
  final Color? baseColor;
  final Color? highlightColor;
  final double? baseOpacity;
  final double? highlightOpacity;
  final double? radius;

  const LeafSkeletonThemeData({
    this.baseColor,
    this.highlightColor,
    this.baseOpacity,
    this.highlightOpacity,
    this.radius,
  });

  LeafSkeletonThemeData copyWith({
    Color? baseColor,
    Color? highlightColor,
    double? baseOpacity,
    double? highlightOpacity,
    double? radius,
  }) {
    return LeafSkeletonThemeData(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      baseOpacity: baseOpacity ?? this.baseOpacity,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      radius: radius ?? this.radius,
    );
  }
}
