import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFGridViewV2', () {
    testWidgets('renders items in a grid', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFGridViewV2<String>(
            items: const ['A', 'B', 'C'],
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('renders header when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              body: LFGridViewV2<String>(
                items: const ['X'],
                header: const Text('Grid Header'),
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Grid Header'), findsOneWidget);
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('uses RefreshIndicator on Android', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              body: LFGridViewV2<String>(
                items: const ['A'],
                onRefresh: () async {},
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('uses CustomScrollView on iOS', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              body: LFGridViewV2<String>(
                items: const ['A'],
                onRefresh: () async {},
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('accepts custom gridDelegate', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFGridViewV2<String>(
            items: const ['A', 'B'],
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('works with controller', (tester) async {
      final controller = LFScrollControllerV2();

      await tester.pumpWidget(
        wrapWithTheme(
          LFGridViewV2<String>(
            items: const ['A'],
            controller: controller,
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      controller.dispose();
    });
  });
}
