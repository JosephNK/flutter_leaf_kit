import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

void main() {
  group('LeafLockGestureDetector', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafLockGestureDetector(
            child: Text('Child'),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafLockGestureDetector(
            onTap: () => tapCount++,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      await tester.pump();

      expect(tapCount, 1);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafLockGestureDetector(
            disabled: true,
            onTap: () => tapCount++,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      await tester.pump();

      expect(tapCount, 0);
    });

    testWidgets('locks after tap for specified duration', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafLockGestureDetector(
            duration: const Duration(milliseconds: 500),
            onTap: () => tapCount++,
            child: const Text('Tap'),
          ),
        ),
      );

      // First tap should work
      await tester.tap(find.text('Tap'));
      await tester.pump();
      expect(tapCount, 1);

      // Second tap immediately should be locked
      await tester.tap(find.text('Tap'));
      await tester.pump();
      expect(tapCount, 1);

      // After duration, tap should work again
      await tester.pump(const Duration(milliseconds: 600));
      await tester.tap(find.text('Tap'));
      await tester.pump();
      expect(tapCount, 2);
    });

    testWidgets('shows loading indicator when loading', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafLockGestureDetector(
            loading: true,
            showLoading: true,
            child: Text('Loading'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides loading indicator when not loading', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafLockGestureDetector(
            loading: false,
            child: Text('Not loading'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
