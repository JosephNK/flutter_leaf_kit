class LeafDuration {
  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration verySlow;

  const LeafDuration({
    required this.fast,
    required this.normal,
    required this.slow,
    required this.verySlow,
  });

  factory LeafDuration.defaults() {
    return const LeafDuration(
      fast: Duration(milliseconds: 150),
      normal: Duration(milliseconds: 250),
      slow: Duration(milliseconds: 300),
      verySlow: Duration(milliseconds: 450),
    );
  }

  LeafDuration copyWith({
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? verySlow,
  }) {
    return LeafDuration(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      verySlow: verySlow ?? this.verySlow,
    );
  }

  static LeafDuration lerp(LeafDuration a, LeafDuration b, double t) {
    return LeafDuration(
      fast: _lerpDuration(a.fast, b.fast, t),
      normal: _lerpDuration(a.normal, b.normal, t),
      slow: _lerpDuration(a.slow, b.slow, t),
      verySlow: _lerpDuration(a.verySlow, b.verySlow, t),
    );
  }

  static Duration _lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      milliseconds:
          (a.inMilliseconds + (b.inMilliseconds - a.inMilliseconds) * t)
              .round(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeafDuration &&
        other.fast == fast &&
        other.normal == normal &&
        other.slow == slow &&
        other.verySlow == verySlow;
  }

  @override
  int get hashCode => Object.hash(fast, normal, slow, verySlow);
}
