import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/painting.dart';

class LFElevation {
  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  final List<BoxShadow> shadowNone;
  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;

  const LFElevation({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.shadowNone,
    required this.shadowSm,
    required this.shadowMd,
    required this.shadowLg,
  });

  factory LFElevation.defaults() {
    return const LFElevation(
      none: 0.0,
      xs: 1.0,
      sm: 2.0,
      md: 4.0,
      lg: 8.0,
      xl: 16.0,
      shadowNone: [],
      shadowSm: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 2.0,
          offset: Offset(0, 1),
        ),
      ],
      shadowMd: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 5.0,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 2.0,
          offset: Offset(0, 1),
        ),
      ],
      shadowLg: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  LFElevation copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    List<BoxShadow>? shadowNone,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowMd,
    List<BoxShadow>? shadowLg,
  }) {
    return LFElevation(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      shadowNone: shadowNone != null
          ? List.unmodifiable(shadowNone)
          : this.shadowNone,
      shadowSm:
          shadowSm != null ? List.unmodifiable(shadowSm) : this.shadowSm,
      shadowMd:
          shadowMd != null ? List.unmodifiable(shadowMd) : this.shadowMd,
      shadowLg:
          shadowLg != null ? List.unmodifiable(shadowLg) : this.shadowLg,
    );
  }

  static LFElevation lerp(LFElevation a, LFElevation b, double t) {
    return LFElevation(
      none: lerpDouble(a.none, b.none, t)!,
      xs: lerpDouble(a.xs, b.xs, t)!,
      sm: lerpDouble(a.sm, b.sm, t)!,
      md: lerpDouble(a.md, b.md, t)!,
      lg: lerpDouble(a.lg, b.lg, t)!,
      xl: lerpDouble(a.xl, b.xl, t)!,
      shadowNone: BoxShadow.lerpList(a.shadowNone, b.shadowNone, t) ?? const [],
      shadowSm: BoxShadow.lerpList(a.shadowSm, b.shadowSm, t) ?? const [],
      shadowMd: BoxShadow.lerpList(a.shadowMd, b.shadowMd, t) ?? const [],
      shadowLg: BoxShadow.lerpList(a.shadowLg, b.shadowLg, t) ?? const [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LFElevation &&
        other.none == none &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        listEquals(other.shadowNone, shadowNone) &&
        listEquals(other.shadowSm, shadowSm) &&
        listEquals(other.shadowMd, shadowMd) &&
        listEquals(other.shadowLg, shadowLg);
  }

  @override
  int get hashCode => Object.hash(
        none,
        xs,
        sm,
        md,
        lg,
        xl,
        Object.hashAll(shadowNone),
        Object.hashAll(shadowSm),
        Object.hashAll(shadowMd),
        Object.hashAll(shadowLg),
      );
}
