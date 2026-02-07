import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_leaf_component/src/v2/atoms/size/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafWidgetSize', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafWidgetSize(
            onChange: (_, _) {},
            child: const SizedBox(width: 100, height: 50),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('reports size via onChange callback', (tester) async {
      Size? reportedSize;
      Offset? reportedPosition;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafWidgetSize(
            onChange: (position, size) {
              reportedPosition = position;
              reportedSize = size;
            },
            child: const SizedBox(width: 100, height: 50),
          ),
        ),
      );

      // Post-frame callback fires after the next frame.
      await tester.pump();

      expect(reportedSize, isNotNull);
      expect(reportedSize!.width, 100.0);
      expect(reportedSize!.height, 50.0);
      expect(reportedPosition, isNotNull);
    });

    testWidgets('does not fire callback when size unchanged', (tester) async {
      int callCount = 0;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafWidgetSize(
            onChange: (_, _) {
              callCount++;
            },
            child: const SizedBox(width: 80, height: 40),
          ),
        ),
      );

      await tester.pump();
      expect(callCount, 1);

      // Pump again without layout change — should not fire again.
      await tester.pump();
      expect(callCount, 1);
    });

    testWidgets('updates callback via updateRenderObject', (tester) async {
      Size? firstSize;
      Size? secondSize;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafWidgetSize(
            onChange: (_, size) {
              firstSize = size;
            },
            child: const SizedBox(width: 60, height: 30),
          ),
        ),
      );

      await tester.pump();
      expect(firstSize, isNotNull);

      // Rebuild with a new callback.
      await tester.pumpWidget(
        wrapWithTheme(
          LeafWidgetSize(
            onChange: (_, size) {
              secondSize = size;
            },
            child: const SizedBox(width: 120, height: 60),
          ),
        ),
      );

      await tester.pump();
      expect(secondSize, isNotNull);
      expect(secondSize!.width, 120.0);
    });
  });
}
