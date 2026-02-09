import 'package:flutter/painting.dart';

/// Visual variants for [LeafCard].
enum LeafCardVariant {
  /// Surface color with shadow elevation.
  elevated,

  /// Border visible, no elevation.
  outlined,

  /// SurfaceVariant background, no border or elevation.
  filled,
}

class LeafCardThemeData {
  final LeafCardVariant? variant;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final List<BoxShadow>? boxShadow;
  final Clip? clipBehavior;

  const LeafCardThemeData({
    this.variant,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.boxShadow,
    this.clipBehavior,
  });

  LeafCardThemeData copyWith({
    LeafCardVariant? variant,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? elevation,
    List<BoxShadow>? boxShadow,
    Clip? clipBehavior,
  }) {
    return LeafCardThemeData(
      variant: variant ?? this.variant,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
      boxShadow: boxShadow ?? this.boxShadow,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }
}
