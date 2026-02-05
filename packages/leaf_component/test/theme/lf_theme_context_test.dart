import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFThemeContext extensions', () {
    testWidgets('context.lfTheme returns theme data', (tester) async {
      final theme = LFThemeData.light();
      late LFThemeData capturedTheme;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedTheme = context.lfTheme;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedTheme.colors, theme.colors);
      expect(capturedTheme.typography, theme.typography);
    });

    testWidgets('context.lfColors returns colors', (tester) async {
      final theme = LFThemeData.light();
      late LFColors capturedColors;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedColors = context.lfColors;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedColors, theme.colors);
    });

    testWidgets('context.lfTypography returns typography', (tester) async {
      final theme = LFThemeData.light();
      late LFTypography capturedTypography;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedTypography = context.lfTypography;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedTypography, theme.typography);
    });

    testWidgets('context.lfSpacing returns spacing', (tester) async {
      final theme = LFThemeData.light();
      late LFSpacing capturedSpacing;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedSpacing = context.lfSpacing;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedSpacing, theme.spacing);
    });

    testWidgets('all extensions work with dark theme', (tester) async {
      final theme = LFThemeData.dark();
      late LFColors capturedColors;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedColors = context.lfColors;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedColors, theme.colors);
    });
  });
}
