import 'package:flutter/widgets.dart';

import '../tokens/leaf_colors.dart';
import '../tokens/leaf_duration.dart';
import '../tokens/leaf_elevation.dart';
import '../tokens/leaf_radius.dart';
import '../tokens/leaf_spacing.dart';
import '../tokens/leaf_typography.dart';
import 'leaf_theme.dart';
import 'leaf_theme_data.dart';

/// Convenience extensions on [BuildContext] for quick access to the LF theme
/// and its design tokens.
///
/// Usage:
/// ```dart
/// final colors = context.leafColors;
/// final typography = context.leafTypography;
/// ```
extension LeafThemeContext on BuildContext {
  LeafThemeData get leafTheme => LeafTheme.of(this);
  LeafColors get leafColors => leafTheme.colors;
  LeafTypography get leafTypography => leafTheme.typography;
  LeafSpacing get leafSpacing => leafTheme.spacing;
  LeafElevation get leafElevation => leafTheme.elevation;
  LeafRadius get leafRadius => leafTheme.radius;
  LeafDuration get leafDuration => leafTheme.duration;
}
