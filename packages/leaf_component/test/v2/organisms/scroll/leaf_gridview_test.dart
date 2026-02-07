import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafGridView', () {
    testWidgets('renders items in a grid', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafGridView<String>(
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
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafGridView<String>(
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
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafGridView<String>(
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
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafGridView<String>(
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
          LeafGridView<String>(
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
      final controller = LeafScrollController();

      await tester.pumpWidget(
        wrapWithTheme(
          LeafGridView<String>(
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
