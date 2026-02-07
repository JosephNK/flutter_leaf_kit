import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafRadio', () {
    testWidgets('renders unselected state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafRadio(text: 'Option 1', value: false),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_off), findsOneWidget);
    });

    testWidgets('renders selected state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafRadio(text: 'Option 1', value: true),
        ),
      );

      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafRadio(
            text: 'Select',
            value: false,
            onChanged: (v) => changedValue = v,
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pump();

      expect(changedValue, isTrue);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        radioTheme: const LeafRadioThemeData(
          activeColor: Colors.purple,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafRadio(text: 'Themed', value: true),
          theme: theme,
        ),
      );

      final icon = tester.widget<Icon>(
        find.byIcon(Icons.radio_button_checked),
      );
      expect(icon.color, Colors.purple);
    });
  });

  group('LeafRadioGroup', () {
    final items = [
      const LeafDataItem(id: 1, text: 'X'),
      const LeafDataItem(id: 2, text: 'Y'),
      const LeafDataItem(id: 3, text: 'Z'),
    ];

    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LeafRadioGroup(items: items)),
      );

      expect(find.text('X'), findsOneWidget);
      expect(find.text('Y'), findsOneWidget);
      expect(find.text('Z'), findsOneWidget);
    });

    testWidgets('shows pre-selected value', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafRadioGroup(items: items, value: items[1]),
        ),
      );

      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_off), findsNWidgets(2));
    });

    testWidgets('calls onChanged on selection', (tester) async {
      LeafDataItem? selectedItem;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafRadioGroup(
            items: items,
            onChanged: (item, checked) {
              selectedItem = item;
            },
          ),
        ),
      );

      await tester.tap(find.text('Z'));
      await tester.pump();

      expect(selectedItem?.text, 'Z');
    });
  });
}
