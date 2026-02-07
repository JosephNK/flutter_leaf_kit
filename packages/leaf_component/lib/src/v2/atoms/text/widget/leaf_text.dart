import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../types/leaf_text_size.dart';

/// A themed text widget that resolves styles from the LF design token system.
///
/// Style resolution order:
///   1. Explicit [style] parameter
///   2. [LeafThemeData.typography.bodyMedium] from the nearest [LeafTheme]
///   3. [DefaultTextStyle] from the widget tree
@immutable
class LeafText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LeafTextSize? textSize;
  final double? height;
  final String? semanticsLabel;

  const LeafText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.left,
    this.color,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textSize,
    this.height,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final resolvedStyle = _resolveStyle(theme);
    final resolvedScaleFactor = _resolveScaleFactor();

    return Semantics(
      label: semanticsLabel ?? text,
      child: Text(
        text,
        style: resolvedStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: (maxLines != null) ? overflow : null,
        textScaler: TextScaler.linear(resolvedScaleFactor),
      ),
    );
  }

  TextStyle _resolveStyle(LeafThemeData theme) {
    final base = style ?? theme.typography.bodyMedium;
    return base.copyWith(
      color: color,
      height: height,
    );
  }

  double _resolveScaleFactor() {
    final size = textSize;
    if (size != null) {
      return size.textScaleFactor;
    }
    return textScaleFactor;
  }
}
