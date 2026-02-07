import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// Size presets for the loading indicator.
enum LFIndicatorSizeV2 { small, medium, large }

extension _LFIndicatorSizeExt on LFIndicatorSizeV2 {
  double get sizeForMaterial {
    switch (this) {
      case LFIndicatorSizeV2.small:
        return 20.0;
      case LFIndicatorSizeV2.medium:
        return 30.0;
      case LFIndicatorSizeV2.large:
        return 40.0;
    }
  }

  double get sizeForCupertino {
    switch (this) {
      case LFIndicatorSizeV2.small:
        return 10.0;
      case LFIndicatorSizeV2.medium:
        return 15.0;
      case LFIndicatorSizeV2.large:
        return 25.0;
    }
  }
}

/// A themed platform-adaptive loading indicator.
///
/// Uses [Theme.of(context).platform] for web-safe platform detection.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFIndicatorThemeData] from the nearest [LFTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LFIndicatorV2 extends StatelessWidget {
  final EdgeInsets? padding;
  final LFIndicatorSizeV2 size;
  final double? strokeWidth;

  const LFIndicatorV2({
    super.key,
    this.padding,
    this.size = LFIndicatorSizeV2.medium,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final indTheme = theme.indicatorTheme;

    final resolvedPadding =
        padding ?? indTheme?.padding ?? EdgeInsets.zero;
    final resolvedStrokeWidth =
        strokeWidth ?? indTheme?.strokeWidth ?? 2.0;

    final platform = Theme.of(context).platform;
    final isApple = platform == TargetPlatform.iOS ||
        platform == TargetPlatform.macOS;

    return Semantics(
      label: 'Loading',
      child: Container(
        padding: resolvedPadding,
        child: isApple
            ? CupertinoActivityIndicator(radius: size.sizeForCupertino)
            : SizedBox(
                width: size.sizeForMaterial,
                height: size.sizeForMaterial,
                child: CircularProgressIndicator(
                  strokeWidth: resolvedStrokeWidth,
                ),
              ),
      ),
    );
  }
}
