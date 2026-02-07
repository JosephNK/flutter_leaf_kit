import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafThemeContext extensions', () {
    testWidgets('context.leafTheme returns theme data', (tester) async {
      final theme = LeafThemeData.light();
      late LeafThemeData capturedTheme;

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedTheme = context.leafTheme;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedTheme.colors, theme.colors);
      expect(capturedTheme.typography, theme.typography);
    });

    testWidgets('context.leafColors returns colors', (tester) async {
      final theme = LeafThemeData.light();
      late LeafColors capturedColors;

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedColors = context.leafColors;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedColors, theme.colors);
    });

    testWidgets('context.leafTypography returns typography', (tester) async {
      final theme = LeafThemeData.light();
      late LeafTypography capturedTypography;

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedTypography = context.leafTypography;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedTypography, theme.typography);
    });

    testWidgets('context.leafSpacing returns spacing', (tester) async {
      final theme = LeafThemeData.light();
      late LeafSpacing capturedSpacing;

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedSpacing = context.leafSpacing;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedSpacing, theme.spacing);
    });

    testWidgets('all extensions work with dark theme', (tester) async {
      final theme = LeafThemeData.dark();
      late LeafColors capturedColors;

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: Builder(
              builder: (context) {
                capturedColors = context.leafColors;
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
