import 'package:flutter/widgets.dart';

import '../tokens/lf_colors.dart';
import '../tokens/lf_duration.dart';
import '../tokens/lf_elevation.dart';
import '../tokens/lf_radius.dart';
import '../tokens/lf_spacing.dart';
import '../tokens/lf_typography.dart';
import 'lf_theme.dart';
import 'lf_theme_data.dart';

/// Convenience extensions on [BuildContext] for quick access to the LF theme
/// and its design tokens.
///
/// Usage:
/// ```dart
/// final colors = context.lfColors;
/// final typography = context.lfTypography;
/// ```
extension LFThemeContext on BuildContext {
  LFThemeData get lfTheme => LFTheme.of(this);
  LFColors get lfColors => lfTheme.colors;
  LFTypography get lfTypography => lfTheme.typography;
  LFSpacing get lfSpacing => lfTheme.spacing;
  LFElevation get lfElevation => lfTheme.elevation;
  LFRadius get lfRadius => lfTheme.radius;
  LFDuration get lfDuration => lfTheme.duration;
}
