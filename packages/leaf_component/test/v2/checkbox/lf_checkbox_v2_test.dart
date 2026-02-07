import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFCheckBoxV2', () {
    testWidgets('renders unchecked state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCheckBoxV2(text: 'Option A', value: false),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
      expect(find.byIcon(Icons.check_box_outline_blank), findsOneWidget);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCheckBoxV2(text: 'Option A', value: true),
        ),
      );

      expect(find.byIcon(Icons.check_box), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LFCheckBoxV2(
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
      final theme = LFThemeData.light().copyWith(
        checkBoxTheme: const LFCheckBoxThemeData(
          activeColor: Colors.green,
          inactiveColor: Colors.red,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LFCheckBoxV2(text: 'Themed', value: true),
          theme: theme,
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.check_box));
      expect(icon.color, Colors.green);
    });

    testWidgets('has checked semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCheckBoxV2(text: 'Check me', value: true),
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

  group('LFCheckBoxGroupV2', () {
    final items = [
      const LFDataItem(id: 1, text: 'A'),
      const LFDataItem(id: 2, text: 'B'),
      const LFDataItem(id: 3, text: 'C'),
    ];

    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LFCheckBoxGroupV2(items: items)),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('shows pre-selected values', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFCheckBoxGroupV2(
            items: items,
            values: [items[0]],
          ),
        ),
      );

      expect(find.byIcon(Icons.check_box), findsOneWidget);
      expect(find.byIcon(Icons.check_box_outline_blank), findsNWidgets(2));
    });

    testWidgets('calls onChanged with selection', (tester) async {
      List<LFDataItem>? selectedItems;
      LFDataItem? changedItem;

      await tester.pumpWidget(
        wrapWithTheme(
          LFCheckBoxGroupV2(
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
