import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafText', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafText('Hello')));

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies explicit style over theme', (tester) async {
      const style = TextStyle(fontSize: 24, color: Colors.red);

      await tester.pumpWidget(
        wrapWithTheme(const LeafText('Styled', style: style)),
      );

      final text = tester.widget<Text>(find.byType(Text).last);
      expect(text.style?.fontSize, 24);
      expect(text.style?.color, Colors.red);
    });

    testWidgets('applies color override', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafText('Colored', color: Colors.green)),
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
        wrapWithTheme(const LeafText('Themed'), theme: customTheme),
      );

      final text = tester.widget<Text>(find.byType(Text).last);
      expect(text.style?.fontSize, 18);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText('Hidden text', semanticsLabel: 'Custom label'),
        ),
      );

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasCustomLabel = semantics.any(
        (s) => s.properties.label == 'Custom label',
      );
      expect(hasCustomLabel, isTrue);
    });

    testWidgets('uses text as default semantics label', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafText('My text')));

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasTextLabel = semantics.any(
        (s) => s.properties.label == 'My text',
      );
      expect(hasTextLabel, isTrue);
    });
  });

  group('LeafText underline', () {
    testWidgets('uses RichText when underline style is set', (tester) async {
      const style = TextStyle(
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

      await tester.pumpWidget(
        wrapWithTheme(const LeafText('안녕하세요', style: style)),
      );

      // Each character gets its own Text widget inside WidgetSpan
      expect(find.byType(Text), findsNWidgets(5));
      // A top-level RichText is created plus one per character Text
      expect(find.byType(RichText), findsAtLeast(1));
    });

    testWidgets('uses Text when no underline', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafText('Hello')));

      final textWidgets = find.byType(Text);
      expect(textWidgets, findsOneWidget);
    });

    testWidgets('preserves color in underline mode', (tester) async {
      const style = TextStyle(
        fontSize: 16,
        color: Colors.blue,
        decoration: TextDecoration.underline,
      );

      await tester.pumpWidget(
        wrapWithTheme(const LeafText('가나다', style: style)),
      );

      final charTexts = tester.widgetList<Text>(find.byType(Text));
      for (final charText in charTexts) {
        expect(charText.style?.color, Colors.blue);
      }
    });

    testWidgets('preserves maxLines and textAlign in underline mode', (
      tester,
    ) async {
      const style = TextStyle(
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText(
            '한글 텍스트',
            style: style,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      expect(richText.maxLines, 2);
      expect(richText.textAlign, TextAlign.center);
    });

    testWidgets('preserves semantics in underline mode', (tester) async {
      const style = TextStyle(
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafText(
            '밑줄 텍스트',
            style: style,
            semanticsLabel: 'Underline label',
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasLabel = semantics.any(
        (s) => s.properties.label == 'Underline label',
      );
      expect(hasLabel, isTrue);
    });

    testWidgets('applies textScaler in underline mode', (tester) async {
      const style = TextStyle(
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

      await tester.pumpWidget(
        wrapWithTheme(const LeafText('크기', style: style, textScaleFactor: 1.5)),
      );

      final richText = tester.widget<RichText>(find.byType(RichText).first);
      expect(richText.textScaler, const TextScaler.linear(1.5));
    });
  });
}
