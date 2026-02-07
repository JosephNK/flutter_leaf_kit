import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

void main() {
  group('LFIconsV2', () {
    testWidgets('renders IconData', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFIconsV2(Icons.home, width: 24),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('renders Icon widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFIconsV2(Icon(Icons.star), width: 24),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('applies color to IconData', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFIconsV2(Icons.home, color: Colors.red, width: 24),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.home));
      expect(icon.color, Colors.red);
    });

    testWidgets('returns SizedBox for unknown asset type', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFIconsV2('unknown', width: 30, height: 30),
        ),
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('updateColor creates icon with new color', (tester) async {
      const original = LFIconsV2(Icons.star, color: Colors.blue, width: 24);

      await tester.pumpWidget(
        wrapWithTheme(
          LFIconsV2.updateColor(original, color: Colors.green),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, Colors.green);
    });
  });
}
