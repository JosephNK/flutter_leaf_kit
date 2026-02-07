import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafTimePicker', () {
    testWidgets('renders with default label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafTimePicker(),
        ),
      );

      expect(find.text('Time'), findsOneWidget);
    });

    testWidgets('renders with custom label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafTimePicker(
            label: Text('End Time'),
          ),
        ),
      );

      expect(find.text('End Time'), findsOneWidget);
    });

    testWidgets('expands time picker on tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        wrapWithTheme(
          SingleChildScrollView(
            child: LeafTimePicker(
              initialTime: DateTime(2025, 1, 1, 14, 30),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Time'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafTimePicker(
            initialTime: DateTime(2025, 1, 1, 9, 0),
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasLabel = semantics.any(
        (s) => s.properties.label?.contains('Time picker') ?? false,
      );
      expect(hasLabel, isTrue);
    });

    testWidgets('uses theme colors', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        pickerTheme: const LeafPickerThemeData(
          activeColor: Colors.purple,
          backgroundColor: Colors.lime,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafTimePicker(),
          theme: theme,
        ),
      );

      expect(find.text('Time'), findsOneWidget);
    });
  });
}
