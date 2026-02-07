import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafAnimationController', () {
    test('initial status is stop', () {
      final controller = LeafAnimationController();
      expect(controller.status, LeafAnimationStatus.stop);
    });

    test('forward returns null without animation controller', () {
      final controller = LeafAnimationController();
      expect(controller.forward(), isNull);
    });

    test('reverse returns null without animation controller', () {
      final controller = LeafAnimationController();
      expect(controller.reverse(), isNull);
    });

    test('repeat returns null without animation controller', () {
      final controller = LeafAnimationController();
      expect(controller.repeat(), isNull);
    });
  });

  group('LeafBouncingAnimated', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafBouncingAnimated(
            enableInitAnimation: false,
            child: Text('Bounce'),
          ),
        ),
      );

      expect(find.text('Bounce'), findsOneWidget);
    });

    testWidgets('contains ScaleTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafBouncingAnimated(
            enableInitAnimation: false,
            child: Text('Bounce'),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafBouncingAnimated),
          matching: find.byType(ScaleTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LeafExpandAnimated', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafExpandAnimated(child: Text('Expand')),
        ),
      );

      expect(find.text('Expand'), findsOneWidget);
    });

    testWidgets('contains SizeTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafExpandAnimated(child: Text('Expand')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafExpandAnimated),
          matching: find.byType(SizeTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LeafFadeAnimated', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafFadeAnimated(child: Text('Fade')),
        ),
      );

      expect(find.text('Fade'), findsOneWidget);
    });

    testWidgets('contains FadeTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafFadeAnimated(child: Text('Fade')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafFadeAnimated),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LeafFlipAnimated', () {
    testWidgets('shows front side by default', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafFlipAnimated(
            front: Text('Front'),
            rear: Text('Rear'),
          ),
        ),
      );

      expect(find.text('Front'), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? value;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafFlipAnimated(
            front: const Text('Front'),
            rear: const Text('Rear'),
            onChanged: (v) => value = v,
          ),
        ),
      );

      await tester.tap(find.text('Front'));
      await tester.pump();

      expect(value, isFalse);
    });
  });

  group('LeafRotateAnimated', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafRotateAnimated(child: Text('Rotate')),
        ),
      );

      expect(find.text('Rotate'), findsOneWidget);
    });
  });

  group('LeafScaleAnimated', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafScaleAnimated(child: Text('Scale')),
        ),
      );

      expect(find.text('Scale'), findsOneWidget);
    });

    testWidgets('contains ScaleTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafScaleAnimated(child: Text('Scale')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafScaleAnimated),
          matching: find.byType(ScaleTransition),
        ),
        findsOneWidget,
      );
    });
  });
}
