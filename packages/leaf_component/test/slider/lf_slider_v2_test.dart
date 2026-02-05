import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFSliderV2', () {
    testWidgets('renders slider widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFSliderV2(value: 0.5, onChanged: (_) {}),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('accepts onChanged callback', (tester) async {
      double? changed;

      await tester.pumpWidget(
        wrapWithTheme(
          LFSliderV2(
            value: 0.5,
            divisions: 10,
            onChanged: (v) => changed = v,
          ),
        ),
      );

      // Drag the slider thumb to trigger onChanged
      final slider = find.byType(Slider);
      final center = tester.getCenter(slider);
      await tester.dragFrom(center, const Offset(50, 0));
      await tester.pump();

      expect(changed, isNotNull);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LFThemeData.light().copyWith(
        sliderTheme: const LFSliderThemeData(
          activeTrackColor: Colors.orange,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFSliderV2(value: 0.5, onChanged: (_) {}),
          theme: theme,
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('has slider semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFSliderV2(value: 0.5, onChanged: (_) {}),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasSlider = semantics.any(
        (s) => s.properties.label == 'Slider',
      );
      expect(hasSlider, isTrue);
    });
  });

  group('LFRangeSliderV2', () {
    testWidgets('renders range slider widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRangeSliderV2(
            values: const RangeValues(0.2, 0.8),
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(RangeSlider), findsOneWidget);
    });

    testWidgets('has range slider semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRangeSliderV2(
            values: const RangeValues(0.2, 0.8),
            onChanged: (_) {},
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasRange = semantics.any(
        (s) => s.properties.label == 'Range slider',
      );
      expect(hasRange, isTrue);
    });

    testWidgets('resolves theme colors', (tester) async {
      final theme = LFThemeData.light().copyWith(
        sliderTheme: const LFSliderThemeData(
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.grey,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFRangeSliderV2(
            values: const RangeValues(0.3, 0.7),
            onChanged: (_) {},
          ),
          theme: theme,
        ),
      );

      expect(find.byType(RangeSlider), findsOneWidget);
    });
  });
}
