import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LFSwitchV2', () {
    testWidgets('renders in off state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFSwitchV2(value: false)),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('renders in on state', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFSwitchV2(value: true)),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('calls onChanged when toggled', (tester) async {
      bool? newValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LFSwitchV2(
            value: false,
            onChanged: (v) => newValue = v,
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(newValue, isTrue);
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LFThemeData.light().copyWith(
        switchTheme: const LFSwitchThemeData(
          activeTrackColor: Colors.green,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(const LFSwitchV2(value: true), theme: theme),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('has toggled semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LFSwitchV2(value: true)),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasToggled = semantics.any(
        (s) => s.properties.toggled == true,
      );
      expect(hasToggled, isTrue);
    });
  });
}
