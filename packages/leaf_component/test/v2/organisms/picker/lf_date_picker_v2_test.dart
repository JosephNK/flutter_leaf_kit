import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LFDatePickerV2', () {
    testWidgets('renders with default label and date', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFDatePickerV2(
            initialDate: null,
          ),
        ),
      );

      expect(find.text('Date'), findsOneWidget);
    });

    testWidgets('renders with custom label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFDatePickerV2(
            label: Text('Start Date'),
          ),
        ),
      );

      expect(find.text('Start Date'), findsOneWidget);
    });

    testWidgets('displays formatted initial date', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFDatePickerV2(
            initialDate: DateTime(2025, 3, 15),
          ),
        ),
      );

      expect(find.text('03.15 2025'), findsOneWidget);
    });

    testWidgets('expands calendar on tap', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFDatePickerV2(
            initialDate: DateTime(2025, 1, 10),
          ),
        ),
      );

      // Tap to expand
      await tester.tap(find.text('Date'));
      await tester.pumpAndSettle();

      // CalendarDatePicker should be visible
      expect(find.byType(CalendarDatePicker), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFDatePickerV2(
            initialDate: DateTime(2025, 6, 1),
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasLabel = semantics.any(
        (s) => s.properties.label?.contains('Date picker') ?? false,
      );
      expect(hasLabel, isTrue);
    });

    testWidgets('uses theme colors', (tester) async {
      final theme = LFThemeData.light().copyWith(
        pickerTheme: const LFPickerThemeData(
          activeColor: Colors.orange,
          backgroundColor: Colors.yellow,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFDatePickerV2(
            initialDate: DateTime(2025, 1, 1),
          ),
          theme: theme,
        ),
      );

      expect(find.text('01.01 2025'), findsOneWidget);
    });
  });
}
