import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFThemeData', () {
    test('light factory creates valid theme', () {
      final theme = LFThemeData.light();
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
      expect(theme.spacing, isNotNull);
      expect(theme.elevation, isNotNull);
      expect(theme.radius, isNotNull);
      expect(theme.duration, isNotNull);
    });

    test('dark factory creates valid theme', () {
      final theme = LFThemeData.dark();
      expect(theme.colors, isNotNull);
      expect(theme.typography, isNotNull);
    });

    test('component themes are null by default', () {
      final theme = LFThemeData.light();
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
      final original = LFThemeData.light().copyWith(
        buttonTheme: const LFButtonThemeData(leadingSpacing: 12),
      );

      final copied = original.copyWith(
        sliderTheme: const LFSliderThemeData(),
      );

      expect(copied.buttonTheme?.leadingSpacing, 12);
      expect(copied.sliderTheme, isNotNull);
    });

    test('copyWith replaces specified values', () {
      final original = LFThemeData.light().copyWith(
        buttonTheme: const LFButtonThemeData(leadingSpacing: 12),
      );

      final copied = original.copyWith(
        buttonTheme: const LFButtonThemeData(leadingSpacing: 24),
      );

      expect(copied.buttonTheme?.leadingSpacing, 24);
    });

    test('copyWith includes new theme fields', () {
      final theme = LFThemeData.light().copyWith(
        sliderTheme: const LFSliderThemeData(),
        ratingBarTheme: const LFRatingBarThemeData(),
        accordionTheme: const LFAccordionThemeData(),
        imageTheme: const LFImageThemeData(),
        navigationBarTheme: const LFNavigationBarThemeData(),
        pickerTheme: const LFPickerThemeData(),
      );

      expect(theme.sliderTheme, isNotNull);
      expect(theme.ratingBarTheme, isNotNull);
      expect(theme.accordionTheme, isNotNull);
      expect(theme.imageTheme, isNotNull);
      expect(theme.navigationBarTheme, isNotNull);
      expect(theme.pickerTheme, isNotNull);
    });

    test('lerp returns first theme before 0.5', () {
      final a = LFThemeData.light().copyWith(
        sliderTheme: const LFSliderThemeData(),
      );
      final b = LFThemeData.dark();

      final result = LFThemeData.lerp(a, b, 0.3);
      expect(result.sliderTheme, isNotNull);
    });

    test('lerp returns second theme at or after 0.5', () {
      final a = LFThemeData.light().copyWith(
        sliderTheme: const LFSliderThemeData(),
      );
      final b = LFThemeData.dark();

      final result = LFThemeData.lerp(a, b, 0.7);
      expect(result.sliderTheme, isNull);
    });
  });
}
