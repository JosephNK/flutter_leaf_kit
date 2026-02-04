import 'package:flutter/material.dart';

import 'lf_theme_data.dart';

class LFThemeDataExtension extends ThemeExtension<LFThemeDataExtension> {
  final LFThemeData data;

  const LFThemeDataExtension({required this.data});

  @override
  LFThemeDataExtension copyWith({LFThemeData? data}) {
    return LFThemeDataExtension(data: data ?? this.data);
  }

  @override
  LFThemeDataExtension lerp(
    covariant ThemeExtension<LFThemeDataExtension>? other,
    double t,
  ) {
    if (other is! LFThemeDataExtension) return this;
    return LFThemeDataExtension(
      data: LFThemeData.lerp(data, other.data, t),
    );
  }
}
