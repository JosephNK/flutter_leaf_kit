import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/v2/templates/navigationbar/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

List<LeafBottomTabItem> _makeItems(int count) {
  return List.generate(
    count,
    (i) => LeafBottomTabItem(
      tabIndex: LeafBottomTabIndex(tabIndex: i),
      defaultIcon: Icon(Icons.circle, key: ValueKey('def_$i')),
      activeIcon: Icon(Icons.check_circle, key: ValueKey('act_$i')),
      label: 'Tab $i',
    ),
  );
}

void main() {
  group('LeafBottomTabBar', () {
    late LeafBottomTabBarController controller;

    setUp(() {
      controller = LeafBottomTabBarController();
      controller.setItems(_makeItems(3), selectedIndex: 0);
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('renders all tab labels', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafBottomTabBar(controller: controller),
        ),
      );

      expect(find.text('Tab 0'), findsOneWidget);
      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafBottomTabBar(controller: controller),
        ),
      );

      expect(
        find.bySemanticsLabel('Bottom navigation bar'),
        findsWidgets,
      );
    });

    testWidgets('onTap fires with correct index', (tester) async {
      int? tappedIndex;
      bool? wasActive;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafBottomTabBar(
            controller: controller,
            onTap: (index, isActive) {
              tappedIndex = index;
              wasActive = isActive;
            },
          ),
        ),
      );

      await tester.tap(find.text('Tab 1'));
      await tester.pump();

      expect(tappedIndex, 1);
      expect(wasActive, isFalse);
    });

    testWidgets('hidden when visible is false', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafBottomTabBar(controller: controller, visible: false),
        ),
      );

      // The BottomAppBar should not be visible
      expect(find.byType(BottomAppBar), findsNothing);
    });
  });
}
