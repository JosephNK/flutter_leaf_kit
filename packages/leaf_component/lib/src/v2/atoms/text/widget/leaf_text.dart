import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../types/leaf_text_size.dart';
import 'leaf_underline_spans.dart';

/// A themed text widget that resolves styles from the LF design token system.
///
/// Use the default constructor for plain text, or [LeafText.rich] for mixed-
/// style text via an [InlineSpan] tree.
///
/// Style resolution order:
///   1. Explicit [style] parameter
///   2. [LeafThemeData.typography.bodyMedium] from the nearest [LeafTheme]
///   3. [DefaultTextStyle] from the widget tree
@immutable
class LeafText extends StatelessWidget {
  final String? _text;
  final InlineSpan? _textSpan;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LeafTextSize? textSize;
  final double? height;
  final String? semanticsLabel;

  /// Creates a themed text widget with a plain string.
  const LeafText(
    String text, {
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
  }) : _text = text,
       _textSpan = null;

  /// Creates a themed text widget with an [InlineSpan] tree for mixed styles.
  ///
  /// The [style] is applied as the default style for the span tree.
  /// Individual spans can override it with their own styles.
  ///
  /// ```dart
  /// LeafText.rich(
  ///   TextSpan(
  ///     text: 'Hello ',
  ///     children: [
  ///       TextSpan(
  ///         text: 'Flutter',
  ///         style: TextStyle(fontWeight: FontWeight.bold),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  const LeafText.rich(
    InlineSpan textSpan, {
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
  }) : _text = null,
       _textSpan = textSpan;

  /// The plain text to display. Non-null when created via the default
  /// constructor.
  String? get text => _text;

  /// The span tree to display. Non-null when created via [LeafText.rich].
  InlineSpan? get textSpan => _textSpan;

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final resolvedStyle = _resolveStyle(theme);
    final resolvedScaleFactor = _resolveScaleFactor();
    final textScaler = TextScaler.linear(resolvedScaleFactor);

    final span = _textSpan;
    if (span != null) {
      return _buildRichText(span, resolvedStyle, textScaler);
    }

    return _buildPlainText(_text!, resolvedStyle, textScaler);
  }

  Widget _buildPlainText(
    String text,
    TextStyle resolvedStyle,
    TextScaler textScaler,
  ) {
    final isUnderline = resolvedStyle.decoration == TextDecoration.underline;

    return Semantics(
      label: semanticsLabel ?? text,
      child: isUnderline
          ? RichText(
              text: TextSpan(
                children: buildUnderlineSpans(text: text, style: resolvedStyle),
              ),
              textAlign: textAlign ?? TextAlign.left,
              maxLines: maxLines,
              overflow: (maxLines != null)
                  ? (overflow ?? TextOverflow.ellipsis)
                  : TextOverflow.clip,
              textScaler: textScaler,
            )
          : Text(
              text,
              style: resolvedStyle,
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: (maxLines != null) ? overflow : null,
              textScaler: textScaler,
            ),
    );
  }

  Widget _buildRichText(
    InlineSpan span,
    TextStyle resolvedStyle,
    TextScaler textScaler,
  ) {
    return Semantics(
      label: semanticsLabel ?? _extractPlainText(span),
      child: Text.rich(
        span,
        style: resolvedStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: (maxLines != null) ? overflow : null,
        textScaler: textScaler,
      ),
    );
  }

  /// Extracts plain text from an [InlineSpan] tree for semantics.
  String _extractPlainText(InlineSpan span) {
    final buffer = StringBuffer();
    span.visitChildren((child) {
      if (child is TextSpan) {
        final text = child.text;
        if (text != null) buffer.write(text);
      }
      return true;
    });
    return buffer.toString();
  }

  TextStyle _resolveStyle(LeafThemeData theme) {
    final base = style ?? theme.typography.bodyMedium;
    return base.copyWith(color: color, height: height);
  }

  double _resolveScaleFactor() {
    final size = textSize;
    if (size != null) {
      return size.textScaleFactor;
    }
    return textScaleFactor;
  }
}
