import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafScrollView', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafScrollView(child: Text('Content'))),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('uses SingleChildScrollView on Android', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(body: LeafScrollView(child: Text('Content'))),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('uses CustomScrollView on iOS', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(body: LeafScrollView(child: Text('Content'))),
          ),
        ),
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('uses RefreshIndicator on Android with onRefresh', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafScrollView(
                onRefresh: () async {},
                child: const Text('Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('disallowGlow wraps with ScrollConfiguration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafScrollView(disallowGlow: true, child: Text('Content')),
            ),
          ),
        ),
      );

      expect(find.byType(ScrollConfiguration), findsWidgets);
    });

    testWidgets('dragKeyboardHide sets onDrag dismiss behavior', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafScrollView(
                dragKeyboardHide: true,
                child: Text('Content'),
              ),
            ),
          ),
        ),
      );

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(
        scrollView.keyboardDismissBehavior,
        ScrollViewKeyboardDismissBehavior.onDrag,
      );
    });

    testWidgets('works with controller', (tester) async {
      final controller = LeafScrollController();

      await tester.pumpWidget(
        wrapWithTheme(
          LeafScrollView(controller: controller, child: const Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      controller.dispose();
    });

    testWidgets('enableTapUnFocus wraps with opaque GestureDetector', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafScrollView(enableTapUnFocus: true, child: Text('Content')),
        ),
      );

      expect(find.byType(GestureDetector), findsWidgets);
    });
  });
}
