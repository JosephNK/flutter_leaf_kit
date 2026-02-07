import 'dart:ui' show lerpDouble;

class LeafRadius {
  final double none;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double full;

  const LeafRadius({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.full,
  });

  factory LeafRadius.defaults() {
    return const LeafRadius(
      none: 0.0,
      sm: 4.0,
      md: 8.0,
      lg: 12.0,
      xl: 16.0,
      xxl: 20.0,
      full: 50.0,
    );
  }

  LeafRadius copyWith({
    double? none,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? full,
  }) {
    return LeafRadius(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      full: full ?? this.full,
    );
  }

  static LeafRadius lerp(LeafRadius a, LeafRadius b, double t) {
    return LeafRadius(
      none: lerpDouble(a.none, b.none, t)!,
      sm: lerpDouble(a.sm, b.sm, t)!,
      md: lerpDouble(a.md, b.md, t)!,
      lg: lerpDouble(a.lg, b.lg, t)!,
      xl: lerpDouble(a.xl, b.xl, t)!,
      xxl: lerpDouble(a.xxl, b.xxl, t)!,
      full: lerpDouble(a.full, b.full, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeafRadius &&
        other.none == none &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.full == full;
  }

  @override
  int get hashCode => Object.hash(none, sm, md, lg, xl, xxl, full);
}
