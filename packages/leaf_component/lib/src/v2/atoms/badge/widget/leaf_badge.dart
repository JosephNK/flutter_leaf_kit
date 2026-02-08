import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed badge widget that displays a small label or icon.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafBadgeThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LeafBadge extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final double? size;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  final double? elevation;

  const LeafBadge({
    super.key,
    this.text,
    this.icon,
    this.size,
    this.textStyle,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final badgeTheme = theme.badgeTheme;

    final resolvedSize = size ?? badgeTheme?.size ?? 18.0;
    final resolvedBg =
        backgroundColor ?? badgeTheme?.backgroundColor ?? colors.error;
    final resolvedIconColor =
        iconColor ?? badgeTheme?.iconColor ?? colors.onError;
    final resolvedPadding =
        padding ??
        badgeTheme?.padding ??
        const EdgeInsets.symmetric(horizontal: 3.0);
    final resolvedElevation = elevation ?? badgeTheme?.elevation ?? 2.0;
    final resolvedTextStyle = textStyle ?? badgeTheme?.textStyle;

    return Semantics(
      label: text ?? 'Badge',
      child: Container(
        constraints: BoxConstraints(
          minHeight: resolvedSize,
          minWidth: resolvedSize,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(resolvedSize / 2.0)),
          ),
          elevation: resolvedElevation,
          color: resolvedBg,
          child: Padding(
            padding: resolvedPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (text != null) Text(text!, style: resolvedTextStyle),
                if (icon != null)
                  Icon(
                    icon,
                    color: resolvedIconColor,
                    size: resolvedSize * 0.4,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
