import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafChip', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafChip(text: 'Tag')),
      );

      expect(find.text('Tag'), findsOneWidget);
    });

    testWidgets('calls onPressed with toggled value', (tester) async {
      bool? pressed;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafChip(
            text: 'Toggle',
            selected: false,
            onPressed: (v) => pressed = v,
          ),
        ),
      );

      await tester.tap(find.text('Toggle'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        chipTheme: const LeafChipThemeData(
          selectedColor: Colors.amber,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafChip(text: 'Themed', selected: true),
          theme: theme,
        ),
      );

      expect(find.text('Themed'), findsOneWidget);
    });

    testWidgets('has selected semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafChip(text: 'Active', selected: true)),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasSelected = semantics.any(
        (s) => s.properties.selected == true,
      );
      expect(hasSelected, isTrue);
    });
  });

  group('LeafChips', () {
    final items = [
      const LeafDataItem(id: 1, text: 'Red'),
      const LeafDataItem(id: 2, text: 'Blue'),
      const LeafDataItem(id: 3, text: 'Green'),
    ];

    testWidgets('renders all chips', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LeafChips(items: items)),
      );

      expect(find.text('Red'), findsOneWidget);
      expect(find.text('Blue'), findsOneWidget);
      expect(find.text('Green'), findsOneWidget);
    });

    testWidgets('supports multi-select', (tester) async {
      List<LeafDataItem>? selected;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafChips(
            items: items,
            multiple: true,
            onChanged: (items, _) => selected = items,
          ),
        ),
      );

      await tester.tap(find.text('Red'));
      await tester.pump();
      await tester.tap(find.text('Blue'));
      await tester.pump();

      expect(selected?.length, 2);
    });

    testWidgets('supports single-select', (tester) async {
      List<LeafDataItem>? selected;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafChips(
            items: items,
            multiple: false,
            onChanged: (items, _) => selected = items,
          ),
        ),
      );

      await tester.tap(find.text('Red'));
      await tester.pump();
      await tester.tap(find.text('Blue'));
      await tester.pump();

      expect(selected?.length, 1);
      expect(selected?.first.text, 'Blue');
    });
  });
}
