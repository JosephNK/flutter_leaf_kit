import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

void main() {
  group('LFBadgeV2', () {
    testWidgets('renders text badge', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFBadgeV2(text: '3')),
      );

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders icon badge', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFBadgeV2(icon: Icons.star)),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LFThemeData.light().copyWith(
        badgeTheme: const LFBadgeThemeData(
          backgroundColor: Colors.orange,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(const LFBadgeV2(text: '1'), theme: theme),
      );

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('explicit backgroundColor overrides theme', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFBadgeV2(
            text: '5',
            backgroundColor: Colors.green,
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFBadgeV2(text: '9')),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasBadgeLabel = semantics.any(
        (s) => s.properties.label == '9',
      );
      expect(hasBadgeLabel, isTrue);
    });
  });
}
