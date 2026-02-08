import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafSwitch', () {
    testWidgets('renders in off state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafSwitch(value: false)));

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('renders in on state', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafSwitch(value: true)));

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('calls onChanged when toggled', (tester) async {
      bool? newValue;

      await tester.pumpWidget(
        wrapWithTheme(LeafSwitch(value: false, onChanged: (v) => newValue = v)),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(newValue, isTrue);
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        switchTheme: const LeafSwitchThemeData(activeTrackColor: Colors.green),
      );

      await tester.pumpWidget(
        wrapWithTheme(const LeafSwitch(value: true), theme: theme),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('has toggled semantics', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafSwitch(value: true)));

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasToggled = semantics.any((s) => s.properties.toggled == true);
      expect(hasToggled, isTrue);
    });
  });
}
