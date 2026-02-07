import 'package:flutter/material.dart';

/// Builds per-character [WidgetSpan]s with a bottom border instead of
/// [TextDecoration.underline], working around Flutter issue #42833 where
/// underline cuts through CJK/Hangul glyphs.
List<InlineSpan> buildUnderlineSpans({
  required String text,
  required TextStyle style,
}) {
  final color = style.decorationColor ?? style.color ?? Colors.black;
  final thickness = style.decorationThickness ?? 1.0;
  final fontSize = style.fontSize ?? 14.0;
  final lineHeight = style.height ?? 1.13;
  final height = fontSize * lineHeight;
  final marginBottom =
      lineHeight > 1.13 ? (lineHeight - 1.13) * fontSize : 0.0;

  final charStyle = style.copyWith(
    height: 1,
    decoration: TextDecoration.none,
  );

  return [
    for (int i = 0; i < text.length; i++)
      WidgetSpan(
        child: Container(
          height: height,
          margin: EdgeInsets.symmetric(vertical: marginBottom / 2),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: color, width: thickness),
              ),
            ),
            child: Text(text[i], style: charStyle),
          ),
        ),
      ),
  ];
}
