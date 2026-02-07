import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafButton', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafButton(text: 'Press Me'),
        ),
      );

      expect(find.text('Press Me'), findsOneWidget);
    });

    testWidgets('calls onTap when pressed', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafButton(
            text: 'Press',
            onTap: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Press'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('uses theme button colors as fallback', (tester) async {
      final customTheme = LeafThemeData.light().copyWith(
        buttonTheme: const LeafButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafButton(text: 'Themed'),
          theme: customTheme,
        ),
      );

      expect(find.text('Themed'), findsOneWidget);
    });

    testWidgets('explicit colors override theme', (tester) async {
      final customTheme = LeafThemeData.light().copyWith(
        buttonTheme: const LeafButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafButton(
            text: 'Override',
            backgroundColor: Colors.purple,
          ),
          theme: customTheme,
        ),
      );

      expect(find.text('Override'), findsOneWidget);
    });

    testWidgets('has button semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafButton(text: 'Action'),
        ),
      );

      final semantics = tester.widget<Semantics>(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.button == true,
        ),
      );
      expect(semantics.properties.label, 'Action');
    });

    testWidgets('renders leading widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafButton(
            text: 'With Icon',
            leading: Icon(Icons.add),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);
    });
  });
}
