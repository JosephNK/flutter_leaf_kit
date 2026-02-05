import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFInkWellV2', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFInkWellV2(
            child: Text('Tap me'),
          ),
        ),
      );

      expect(find.text('Tap me'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTheme(
          LFInkWellV2(
            onTap: () => tapped = true,
            child: const Text('Tap me'),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTheme(
          LFInkWellV2(
            disabled: true,
            onTap: () => tapped = true,
            child: const Text('Tap me'),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets('applies decoration', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFInkWellV2(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Styled'),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byType(Material),
          matching: find.byType(Container),
        ).first,
      );

      expect(container.decoration, isA<BoxDecoration>());
    });
  });
}
