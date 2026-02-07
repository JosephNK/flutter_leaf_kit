import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafThemeData', () {
    test('light factory creates valid theme', () {
      final theme = LeafThemeData.light();
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
      expect(theme.spacing, isNotNull);
      expect(theme.elevation, isNotNull);
      expect(theme.radius, isNotNull);
      expect(theme.duration, isNotNull);
    });

    test('dark factory creates valid theme', () {
      final theme = LeafThemeData.dark();
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
    });

    test('component themes are null by default', () {
      final theme = LeafThemeData.light();
      expect(theme.buttonTheme, isNull);
      expect(theme.appBarTheme, isNull);
      expect(theme.textFieldTheme, isNull);
      expect(theme.sliderTheme, isNull);
      expect(theme.ratingBarTheme, isNull);
      expect(theme.accordionTheme, isNull);
      expect(theme.imageTheme, isNull);
      expect(theme.navigationBarTheme, isNull);
      expect(theme.pickerTheme, isNull);
    });

    test('copyWith preserves existing values', () {
      final original = LeafThemeData.light().copyWith(
        buttonTheme: const LeafButtonThemeData(leadingSpacing: 12),
      );

      final copied = original.copyWith(
        sliderTheme: const LeafSliderThemeData(),
      );

      expect(copied.buttonTheme?.leadingSpacing, 12);
      expect(copied.sliderTheme, isNotNull);
    });

    test('copyWith replaces specified values', () {
      final original = LeafThemeData.light().copyWith(
        buttonTheme: const LeafButtonThemeData(leadingSpacing: 12),
      );

      final copied = original.copyWith(
        buttonTheme: const LeafButtonThemeData(leadingSpacing: 24),
      );

      expect(copied.buttonTheme?.leadingSpacing, 24);
    });

    test('copyWith includes new theme fields', () {
      final theme = LeafThemeData.light().copyWith(
        sliderTheme: const LeafSliderThemeData(),
        ratingBarTheme: const LeafRatingBarThemeData(),
        accordionTheme: const LeafAccordionThemeData(),
        imageTheme: const LeafImageThemeData(),
        navigationBarTheme: const LeafNavigationBarThemeData(),
        pickerTheme: const LeafPickerThemeData(),
      );

      expect(theme.sliderTheme, isNotNull);
      expect(theme.ratingBarTheme, isNotNull);
      expect(theme.accordionTheme, isNotNull);
      expect(theme.imageTheme, isNotNull);
      expect(theme.navigationBarTheme, isNotNull);
      expect(theme.pickerTheme, isNotNull);
    });

    test('lerp returns first theme before 0.5', () {
      final a = LeafThemeData.light().copyWith(
        sliderTheme: const LeafSliderThemeData(),
      );
      final b = LeafThemeData.dark();

      final result = LeafThemeData.lerp(a, b, 0.3);
      expect(result.sliderTheme, isNotNull);
    });

    test('lerp returns second theme at or after 0.5', () {
      final a = LeafThemeData.light().copyWith(
        sliderTheme: const LeafSliderThemeData(),
      );
      final b = LeafThemeData.dark();

      final result = LeafThemeData.lerp(a, b, 0.7);
      expect(result.sliderTheme, isNull);
    });
  });
}
