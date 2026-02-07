import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/v2/templates/navigationbar/index.dart';
import 'package:flutter_leaf_component/src/common/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';


List<LFBottomTabItemV2> _makeItems(int count) {
  return List.generate(
    count,
    (i) => LFBottomTabItemV2(
      tabIndex: LFBottomTabIndexV2(tabIndex: i),
      defaultIcon: Icon(Icons.circle, key: ValueKey('def_$i')),
      label: 'Tab $i',
    ),
  );
}

void main() {
  group('LFBottomTabBarScaffoldV2', () {
    late LFBottomTabBarControllerV2 controller;

    setUp(() {
      controller = LFBottomTabBarControllerV2();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('renders scaffold with tab bar and views', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: LFBottomTabBarScaffoldV2(
              controller: controller,
              tabItems: _makeItems(3),
              selectedIndex: 0,
              viewBuilder: (items) => [
                const Text('Page 0'),
                const Text('Page 1'),
                const Text('Page 2'),
              ],
            ),
          ),
        ),
      );

      // Tab bar labels should be visible
      expect(find.text('Tab 0'), findsOneWidget);
      expect(find.text('Tab 1'), findsOneWidget);

      // First page should be visible (IndexedStack)
      expect(find.text('Page 0'), findsOneWidget);
    });

    testWidgets('tapping a tab changes the view', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: LFBottomTabBarScaffoldV2(
              controller: controller,
              tabItems: _makeItems(3),
              selectedIndex: 0,
              viewBuilder: (items) => [
                const Center(child: Text('Page 0')),
                const Center(child: Text('Page 1')),
                const Center(child: Text('Page 2')),
              ],
            ),
          ),
        ),
      );

      expect(controller.selectedIndex, 0);

      // Tap second tab
      await tester.tap(find.text('Tab 1'));
      await tester.pump();

      expect(controller.selectedIndex, 1);
    });

    testWidgets('deactivateIndexes prevents tab selection', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: LFBottomTabBarScaffoldV2(
              controller: controller,
              tabItems: _makeItems(3),
              selectedIndex: 0,
              deactivateIndexes: const [1],
              viewBuilder: (items) => [
                const Text('Page 0'),
                const Text('Page 1'),
                const Text('Page 2'),
              ],
            ),
          ),
        ),
      );

      // Tap deactivated tab
      await tester.tap(find.text('Tab 1'));
      await tester.pump();

      // Index should not change
      expect(controller.selectedIndex, 0);
    });

    testWidgets('hides tab bar when showTabBar is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: LFBottomTabBarScaffoldV2(
              controller: controller,
              tabItems: _makeItems(3),
              showTabBar: false,
              viewBuilder: (items) => [
                const Text('Page 0'),
                const Text('Page 1'),
                const Text('Page 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(BottomAppBar), findsNothing);
    });
  });
}
