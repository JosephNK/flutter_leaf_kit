import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_leaf_component/src/v2/atoms/painter/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LFTimelinePainterV2', () {
    testWidgets('renders CustomPaint with painter', (tester) async {
      final painter = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
      );

      await tester.pumpWidget(
        wrapWithTheme(
          CustomPaint(
            painter: painter,
            size: const Size(20, 100),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    test('shouldRepaint returns true when lineColor changes', () {
      final painter1 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
      );
      final painter2 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.red,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when properties are identical', () {
      final painter1 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
        strokeWidth: 2.0,
        itemGap: 3.0,
      );
      final painter2 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
        strokeWidth: 2.0,
        itemGap: 3.0,
      );

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    test('shouldRepaint returns true when strokeWidth changes', () {
      final painter1 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
        strokeWidth: 2.0,
      );
      final painter2 = LFTimelinePainterV2(
        width: 20,
        lineColor: Colors.blue,
        strokeWidth: 4.0,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });
  });
}
