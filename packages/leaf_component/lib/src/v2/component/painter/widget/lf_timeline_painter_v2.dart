import 'package:flutter/material.dart';

/// A [CustomPainter] that draws a vertical timeline line between items.
///
/// The line is drawn from just below the top circle to just above the bottom,
/// leaving [itemGap] spacing at each end.
///
/// No theme required — colors are passed as parameters.
class LFTimelinePainterV2 extends CustomPainter {
  /// Total width of the timeline indicator area.
  final double width;

  /// Stroke cap style for the line.
  final StrokeCap strokeCap;

  /// Width of the timeline stroke.
  final double strokeWidth;

  /// Gap between the circle indicator and the line endpoints.
  final double itemGap;

  /// Fill style for the line paint.
  final PaintingStyle style;

  /// Color of the timeline line.
  final Color lineColor;

  final Paint _linePaint;

  LFTimelinePainterV2({
    required this.width,
    required this.lineColor,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 2.0,
    this.itemGap = 3.0,
    this.style = PaintingStyle.stroke,
  }) : _linePaint = Paint()
          ..color = lineColor
          ..strokeCap = strokeCap
          ..strokeWidth = strokeWidth
          ..style = style;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = width / 2;
    final p1 = Offset(radius, width + itemGap);
    final p2 = Offset(size.width - radius, size.height - itemGap);
    if (p1.dy < p2.dy) {
      canvas.drawLine(p1, p2, _linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant LFTimelinePainterV2 oldDelegate) {
    return oldDelegate.width != width ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.strokeCap != strokeCap ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.itemGap != itemGap ||
        oldDelegate.style != style;
  }
}
