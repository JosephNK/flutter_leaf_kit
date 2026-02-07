import 'package:flutter/material.dart';

import 'leaf_theme_data.dart';

class LeafThemeDataExtension extends ThemeExtension<LeafThemeDataExtension> {
  final LeafThemeData data;

  const LeafThemeDataExtension({required this.data});

  @override
  LeafThemeDataExtension copyWith({LeafThemeData? data}) {
    return LeafThemeDataExtension(data: data ?? this.data);
  }

  @override
  LeafThemeDataExtension lerp(
    covariant ThemeExtension<LeafThemeDataExtension>? other,
    double t,
  ) {
    if (other is! LeafThemeDataExtension) return this;
    return LeafThemeDataExtension(
      data: LeafThemeData.lerp(data, other.data, t),
    );
  }
}
