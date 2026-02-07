import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/theme/theme.dart';

/// A themed shimmer/skeleton loading placeholder.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFSkeletonThemeData] from the nearest [LFTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LFSkeletonV2 extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Color? baseColor;
  final Color? highlightColor;
  final double? baseOpacity;
  final double? highlightOpacity;
  final Widget? child;

  const LFSkeletonV2({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.baseColor,
    this.highlightColor,
    this.baseOpacity,
    this.highlightOpacity,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final skTheme = theme.skeletonTheme;

    final resolvedBaseColor = baseColor ?? skTheme?.baseColor ?? colors.shimmerBase;
    final resolvedHighlightColor =
        highlightColor ?? skTheme?.highlightColor ?? colors.shimmerHighlight;
    final resolvedBaseOpacity = baseOpacity ?? skTheme?.baseOpacity ?? 0.3;
    final resolvedHighlightOpacity =
        highlightOpacity ?? skTheme?.highlightOpacity ?? 0.1;
    final resolvedRadius = radius ?? skTheme?.radius ?? 0.0;

    return Semantics(
      label: 'Loading placeholder',
      child: Shimmer.fromColors(
        baseColor: resolvedBaseColor.withValues(alpha: resolvedBaseOpacity),
        highlightColor:
            resolvedHighlightColor.withValues(alpha: resolvedHighlightOpacity),
        child: child ??
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(resolvedRadius),
              ),
            ),
      ),
    );
  }
}
