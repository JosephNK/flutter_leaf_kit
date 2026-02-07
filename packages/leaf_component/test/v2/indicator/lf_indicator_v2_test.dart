import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFIndicatorV2', () {
    testWidgets('renders loading indicator', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFIndicatorV2()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('has loading semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFIndicatorV2()),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasLoading = semantics.any(
        (s) => s.properties.label == 'Loading',
      );
      expect(hasLoading, isTrue);
    });

    testWidgets('respects theme padding', (tester) async {
      final theme = LFThemeData.light().copyWith(
        indicatorTheme: const LFIndicatorThemeData(
          padding: EdgeInsets.all(16.0),
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(const LFIndicatorV2(), theme: theme),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('LFPageCircleIndicatorV2', () {
    testWidgets('renders correct number of dots', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPageCircleIndicatorV2(total: 5, current: 0),
        ),
      );

      final containers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      expect(containers.length, 5);
    });

    testWidgets('has page semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPageCircleIndicatorV2(total: 3, current: 1),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasPageLabel = semantics.any(
        (s) => s.properties.label == 'Page 2 of 3',
      );
      expect(hasPageLabel, isTrue);
    });

    testWidgets('resolves active color from theme', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPageCircleIndicatorV2(
            total: 3,
            current: 0,
            activeColor: Colors.red,
          ),
        ),
      );

      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });
  });

  group('LFPageRectIndicatorV2', () {
    testWidgets('renders correct number of dots', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPageRectIndicatorV2(total: 4, current: 2),
        ),
      );

      final containers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      expect(containers.length, 4);
    });

    testWidgets('has page semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPageRectIndicatorV2(total: 5, current: 3),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasPageLabel = semantics.any(
        (s) => s.properties.label == 'Page 4 of 5',
      );
      expect(hasPageLabel, isTrue);
    });
  });
}
