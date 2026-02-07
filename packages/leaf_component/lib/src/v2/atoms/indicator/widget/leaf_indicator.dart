import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// Size presets for the loading indicator.
enum LeafIndicatorSize { small, medium, large }

extension _LeafIndicatorSizeExt on LeafIndicatorSize {
  double get sizeForMaterial {
    switch (this) {
      case LeafIndicatorSize.small:
        return 20.0;
      case LeafIndicatorSize.medium:
        return 30.0;
      case LeafIndicatorSize.large:
        return 40.0;
    }
  }

  double get sizeForCupertino {
    switch (this) {
      case LeafIndicatorSize.small:
        return 10.0;
      case LeafIndicatorSize.medium:
        return 15.0;
      case LeafIndicatorSize.large:
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
///   2. [LeafIndicatorThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LeafIndicator extends StatelessWidget {
  final EdgeInsets? padding;
  final LeafIndicatorSize size;
  final double? strokeWidth;

  const LeafIndicator({
    super.key,
    this.padding,
    this.size = LeafIndicatorSize.medium,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
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
