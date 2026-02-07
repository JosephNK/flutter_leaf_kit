import 'dart:ui' show lerpDouble;

class LeafSpacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  const LeafSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
  });

  factory LeafSpacing.defaults() {
    return const LeafSpacing(
      xs: 2.0,
      sm: 4.0,
      md: 8.0,
      lg: 12.0,
      xl: 16.0,
      xxl: 24.0,
      xxxl: 32.0,
    );
  }

  LeafSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return LeafSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  static LeafSpacing lerp(LeafSpacing a, LeafSpacing b, double t) {
    return LeafSpacing(
      xs: lerpDouble(a.xs, b.xs, t)!,
      sm: lerpDouble(a.sm, b.sm, t)!,
      md: lerpDouble(a.md, b.md, t)!,
      lg: lerpDouble(a.lg, b.lg, t)!,
      xl: lerpDouble(a.xl, b.xl, t)!,
      xxl: lerpDouble(a.xxl, b.xxl, t)!,
      xxxl: lerpDouble(a.xxxl, b.xxxl, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeafSpacing &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.xxxl == xxxl;
  }

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, xxl, xxxl);
}
