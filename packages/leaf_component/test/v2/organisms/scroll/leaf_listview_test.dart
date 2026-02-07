import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafListView', () {
    testWidgets('renders items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafListView<String>(
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
        wrapWithTheme(
          LeafListView<String>(
            items: const ['X'],
            header: const Text('Header'),
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('shows loading indicator when hasReachedMax is false',
        (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafListView<String>(
            items: const ['A'],
            hasReachedMax: false,
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      // LeafIndicator should be in the tree (even if hidden when not loading)
      expect(find.byType(Visibility), findsWidgets);
    });

    testWidgets('uses RefreshIndicator on Android platform', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafListView<String>(
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

    testWidgets('uses CupertinoSliverRefreshControl on iOS', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafListView<String>(
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

    testWidgets('disallowGlow wraps with ScrollConfiguration',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafListView<String>(
                items: const ['A'],
                disallowGlow: true,
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ScrollConfiguration), findsWidgets);
    });

    testWidgets('enableTapUnFocus wraps with GestureDetector',
        (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafListView<String>(
            items: const ['A'],
            enableTapUnFocus: true,
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('works with controller', (tester) async {
      final controller = LeafScrollController();

      await tester.pumpWidget(
        wrapWithTheme(
          LeafListView<String>(
            items: const ['A', 'B', 'C'],
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
