part of '../painter.dart';

class LFTimelinePainter extends CustomPainter {
  final double width;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final double itemGap;
  final PaintingStyle style;
  final Color lineColor;
  final Paint linePaint;

  LFTimelinePainter({
    required this.width,
    required this.lineColor,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 2.0,
    this.itemGap = 3.0,
    this.style = PaintingStyle.stroke,
  }) : linePaint = Paint()
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
      canvas.drawLine(p1, p2, linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
