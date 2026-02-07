import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafCheckBox', () {
    testWidgets('renders unchecked state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCheckBox(text: 'Option A', value: false),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
      expect(find.byIcon(Icons.check_box_outline_blank), findsOneWidget);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCheckBox(text: 'Option A', value: true),
        ),
      );

      expect(find.byIcon(Icons.check_box), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafCheckBox(
            text: 'Toggle',
            value: false,
            onChanged: (v) => changedValue = v,
          ),
        ),
      );

      await tester.tap(find.text('Toggle'));
      await tester.pump();

      expect(changedValue, isTrue);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        checkBoxTheme: const LeafCheckBoxThemeData(
          activeColor: Colors.green,
          inactiveColor: Colors.red,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCheckBox(text: 'Themed', value: true),
          theme: theme,
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.check_box));
      expect(icon.color, Colors.green);
    });

    testWidgets('has checked semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCheckBox(text: 'Check me', value: true),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasChecked = semantics.any(
        (s) => s.properties.checked == true,
      );
      expect(hasChecked, isTrue);
    });
  });

  group('LeafCheckBoxGroup', () {
    final items = [
      const LeafDataItem(id: 1, text: 'A'),
      const LeafDataItem(id: 2, text: 'B'),
      const LeafDataItem(id: 3, text: 'C'),
    ];

    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LeafCheckBoxGroup(items: items)),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('shows pre-selected values', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafCheckBoxGroup(
            items: items,
            values: [items[0]],
          ),
        ),
      );

      expect(find.byIcon(Icons.check_box), findsOneWidget);
      expect(find.byIcon(Icons.check_box_outline_blank), findsNWidgets(2));
    });

    testWidgets('calls onChanged with selection', (tester) async {
      List<LeafDataItem>? selectedItems;
      LeafDataItem? changedItem;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafCheckBoxGroup(
            items: items,
            onChanged: (items, changed) {
              selectedItems = items;
              changedItem = changed;
            },
          ),
        ),
      );

      await tester.tap(find.text('B'));
      await tester.pump();

      expect(changedItem?.text, 'B');
      expect(selectedItems?.length, 1);
    });
  });
}
