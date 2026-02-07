import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LFAnimationControllerV2', () {
    test('initial status is stop', () {
      final controller = LFAnimationControllerV2();
      expect(controller.status, LFAnimationStatusV2.stop);
    });

    test('forward returns null without animation controller', () {
      final controller = LFAnimationControllerV2();
      expect(controller.forward(), isNull);
    });

    test('reverse returns null without animation controller', () {
      final controller = LFAnimationControllerV2();
      expect(controller.reverse(), isNull);
    });

    test('repeat returns null without animation controller', () {
      final controller = LFAnimationControllerV2();
      expect(controller.repeat(), isNull);
    });
  });

  group('LFBouncingAnimatedV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFBouncingAnimatedV2(
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
          const LFBouncingAnimatedV2(
            enableInitAnimation: false,
            child: Text('Bounce'),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFBouncingAnimatedV2),
          matching: find.byType(ScaleTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LFExpandAnimatedV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFExpandAnimatedV2(child: Text('Expand')),
        ),
      );

      expect(find.text('Expand'), findsOneWidget);
    });

    testWidgets('contains SizeTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFExpandAnimatedV2(child: Text('Expand')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFExpandAnimatedV2),
          matching: find.byType(SizeTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LFFadeAnimatedV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFFadeAnimatedV2(child: Text('Fade')),
        ),
      );

      expect(find.text('Fade'), findsOneWidget);
    });

    testWidgets('contains FadeTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFFadeAnimatedV2(child: Text('Fade')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFFadeAnimatedV2),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });
  });

  group('LFFlipAnimatedV2', () {
    testWidgets('shows front side by default', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFFlipAnimatedV2(
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
          LFFlipAnimatedV2(
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

  group('LFRotateAnimatedV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFRotateAnimatedV2(child: Text('Rotate')),
        ),
      );

      expect(find.text('Rotate'), findsOneWidget);
    });
  });

  group('LFScaleAnimatedV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFScaleAnimatedV2(child: Text('Scale')),
        ),
      );

      expect(find.text('Scale'), findsOneWidget);
    });

    testWidgets('contains ScaleTransition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFScaleAnimatedV2(child: Text('Scale')),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFScaleAnimatedV2),
          matching: find.byType(ScaleTransition),
        ),
        findsOneWidget,
      );
    });
  });
}
