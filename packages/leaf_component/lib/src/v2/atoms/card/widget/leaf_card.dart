import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../../common/tokens/tokens.dart';

/// A themed card widget with variant styles, optional header/footer slots,
/// and built-in tap support.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafCardThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LeafCard extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final Widget? footer;

  final LeafCardVariant? variant;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final List<BoxShadow>? boxShadow;
  final Clip? clipBehavior;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final String? semanticLabel;

  const LeafCard({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.variant,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.boxShadow,
    this.clipBehavior,
    this.onTap,
    this.onLongPress,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final cardTheme = theme.cardTheme;

    final resolvedVariant =
        variant ?? cardTheme?.variant ?? LeafCardVariant.elevated;
    final resolvedBorderRadius =
        borderRadius ?? cardTheme?.borderRadius ?? theme.radius.lg;
    final resolvedPadding =
        padding ?? cardTheme?.padding ?? const EdgeInsets.all(16.0);
    final resolvedMargin = margin ?? cardTheme?.margin;
    final resolvedClip =
        clipBehavior ?? cardTheme?.clipBehavior ?? Clip.antiAlias;

    final resolvedBg =
        backgroundColor ??
        cardTheme?.backgroundColor ??
        _defaultBackgroundColor(resolvedVariant, colors);
    final resolvedBorderColor =
        borderColor ??
        cardTheme?.borderColor ??
        _defaultBorderColor(resolvedVariant, colors);
    final resolvedBorderWidth =
        borderWidth ??
        cardTheme?.borderWidth ??
        _defaultBorderWidth(resolvedVariant);
    final resolvedElevation =
        elevation ?? cardTheme?.elevation ?? _defaultElevation(resolvedVariant);
    final resolvedBoxShadow = boxShadow ?? cardTheme?.boxShadow;

    final borderRadiusGeometry = BorderRadius.circular(resolvedBorderRadius);

    final content = _buildContent(resolvedPadding);

    final decoration = BoxDecoration(
      color: resolvedBg,
      borderRadius: borderRadiusGeometry,
      border: resolvedBorderWidth > 0
          ? Border.all(color: resolvedBorderColor, width: resolvedBorderWidth)
          : null,
      boxShadow: resolvedBoxShadow,
    );

    Widget card = Material(
      type: MaterialType.card,
      color: Colors.transparent,
      elevation: resolvedBoxShadow != null ? 0.0 : resolvedElevation,
      borderRadius: borderRadiusGeometry,
      clipBehavior: resolvedClip,
      child: Container(
        decoration: decoration,
        child: onTap != null || onLongPress != null
            ? InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                borderRadius: borderRadiusGeometry,
                child: content,
              )
            : content,
      ),
    );

    if (resolvedMargin != null) {
      card = Padding(padding: resolvedMargin, child: card);
    }

    return Semantics(
      label: semanticLabel ?? 'Card',
      container: true,
      child: card,
    );
  }

  Widget _buildContent(EdgeInsets padding) {
    if (header == null && footer == null) {
      return Padding(padding: padding, child: child);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (header != null) Padding(padding: padding, child: header!),
        if (header != null) const Divider(height: 1),
        Padding(padding: padding, child: child),
        if (footer != null) const Divider(height: 1),
        if (footer != null) Padding(padding: padding, child: footer!),
      ],
    );
  }

  Color _defaultBackgroundColor(LeafCardVariant v, LeafColors colors) {
    switch (v) {
      case LeafCardVariant.elevated:
        return colors.surface;
      case LeafCardVariant.outlined:
        return colors.surface;
      case LeafCardVariant.filled:
        return colors.surfaceVariant;
    }
  }

  Color _defaultBorderColor(LeafCardVariant v, LeafColors colors) {
    switch (v) {
      case LeafCardVariant.elevated:
        return Colors.transparent;
      case LeafCardVariant.outlined:
        return colors.divider;
      case LeafCardVariant.filled:
        return Colors.transparent;
    }
  }

  double _defaultBorderWidth(LeafCardVariant v) {
    switch (v) {
      case LeafCardVariant.elevated:
        return 0.0;
      case LeafCardVariant.outlined:
        return 1.0;
      case LeafCardVariant.filled:
        return 0.0;
    }
  }

  double _defaultElevation(LeafCardVariant v) {
    switch (v) {
      case LeafCardVariant.elevated:
        return 2.0;
      case LeafCardVariant.outlined:
        return 0.0;
      case LeafCardVariant.filled:
        return 0.0;
    }
  }
}
