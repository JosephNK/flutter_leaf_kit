import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafText', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafText('Hello')),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies explicit style over theme', (tester) async {
      const style = TextStyle(fontSize: 24, color: Colors.red);

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText('Styled', style: style),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text).last);
      expect(text.style?.fontSize, 24);
      expect(text.style?.color, Colors.red);
    });

    testWidgets('applies color override', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText('Colored', color: Colors.green),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text).last);
      expect(text.style?.color, Colors.green);
    });

    testWidgets('uses theme typography as fallback', (tester) async {
      final customTheme = LeafThemeData.light().copyWith(
        typography: LeafTypography.defaults().copyWith(
          bodyMedium: const TextStyle(fontSize: 18),
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText('Themed'),
          theme: customTheme,
        ),
      );

      final text = tester.widget<Text>(find.byType(Text).last);
      expect(text.style?.fontSize, 18);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText(
            'Hidden text',
            semanticsLabel: 'Custom label',
          ),
        ),
      );

      // Find the Semantics widget that directly wraps our Text
      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasCustomLabel = semantics.any(
        (s) => s.properties.label == 'Custom label',
      );
      expect(hasCustomLabel, isTrue);
    });

    testWidgets('uses text as default semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafText('My text')),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasTextLabel = semantics.any(
        (s) => s.properties.label == 'My text',
      );
      expect(hasTextLabel, isTrue);
    });
  });
}
