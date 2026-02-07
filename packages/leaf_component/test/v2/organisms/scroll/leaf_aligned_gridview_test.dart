import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
  );

  group('LeafAlignedGridView', () {
    testWidgets('renders items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafAlignedGridView<String>(
            items: const ['A', 'B', 'C'],
            gridDelegate: gridDelegate,
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('renders header when provided on Android', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafAlignedGridView<String>(
                items: const ['X'],
                gridDelegate: gridDelegate,
                header: const Text('Grid Header'),
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Grid Header'), findsOneWidget);
    });

    testWidgets('uses RefreshIndicator on Android', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafAlignedGridView<String>(
                items: const ['A'],
                gridDelegate: gridDelegate,
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
              body: LeafAlignedGridView<String>(
                items: const ['A'],
                gridDelegate: gridDelegate,
                onRefresh: () async {},
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('shows loading indicator when hasReachedMax is false on Android',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafAlignedGridView<String>(
                items: const ['A'],
                gridDelegate: gridDelegate,
                hasReachedMax: false,
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Visibility), findsWidgets);
    });

    testWidgets('works with controller', (tester) async {
      final controller = LeafScrollController();

      await tester.pumpWidget(
        wrapWithTheme(
          LeafAlignedGridView<String>(
            items: const ['A'],
            gridDelegate: gridDelegate,
            controller: controller,
            builder: (_, item, _) => Text(item),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      controller.dispose();
    });

    testWidgets('disallowGlow wraps with ScrollConfiguration',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafAlignedGridView<String>(
                items: const ['A'],
                gridDelegate: gridDelegate,
                disallowGlow: true,
                builder: (_, item, _) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ScrollConfiguration), findsWidgets);
    });
  });
}
