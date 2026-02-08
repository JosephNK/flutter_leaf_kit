import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafIcons', () {
    testWidgets('renders IconData', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafIcons(Icons.home, width: 24)),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('renders Icon widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafIcons(Icon(Icons.star), width: 24)),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('applies color to IconData', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafIcons(Icons.home, color: Colors.red, width: 24),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.home));
      expect(icon.color, Colors.red);
    });

    testWidgets('returns SizedBox for unknown asset type', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafIcons('unknown', width: 30, height: 30)),
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('updateColor creates icon with new color', (tester) async {
      const original = LeafIcons(Icons.star, color: Colors.blue, width: 24);

      await tester.pumpWidget(
        wrapWithTheme(LeafIcons.updateColor(original, color: Colors.green)),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, Colors.green);
    });
  });
}
