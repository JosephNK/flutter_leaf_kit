import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

Widget _wrapWithTabController({
  required List<Tab> tabs,
  required Widget child,
  LeafThemeData? theme,
}) {
  return wrapWithTheme(
    DefaultTabController(
      length: tabs.length,
      child: Column(children: [child]),
    ),
    theme: theme,
  );
}

void main() {
  group('LeafTabBar', () {
    testWidgets('renders tabs', (tester) async {
      const tabs = [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(tabs: tabs),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        tabBarTheme: const LeafTabBarThemeData(
          labelColor: Colors.red,
          indicatorColor: Colors.red,
        ),
      );
      const tabs = [Tab(text: 'A'), Tab(text: 'B')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(tabs: tabs),
          theme: theme,
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.labelColor, Colors.red);
      expect(tabBar.indicatorColor, Colors.red);
    });

    testWidgets('explicit colors override theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        tabBarTheme: const LeafTabBarThemeData(
          labelColor: Colors.red,
        ),
      );
      const tabs = [Tab(text: 'A'), Tab(text: 'B')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(
            tabs: tabs,
            labelColor: Colors.green,
          ),
          theme: theme,
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.labelColor, Colors.green);
    });

    testWidgets('has semantics label', (tester) async {
      const tabs = [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(tabs: tabs),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasTabBarLabel = semantics.any(
        (s) => s.properties.label == 'Tab bar',
      );
      expect(hasTabBarLabel, isTrue);
    });

    testWidgets('fires onTap callback', (tester) async {
      int? tappedIndex;
      const tabs = [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: LeafTabBar(
            tabs: tabs,
            onTap: (index) => tappedIndex = index,
          ),
        ),
      );

      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();

      expect(tappedIndex, 1);
    });

    testWidgets('supports isScrollable', (tester) async {
      const tabs = [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(tabs: tabs, isScrollable: true),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.isScrollable, isTrue);
    });

    testWidgets('passes indicatorSize through', (tester) async {
      const tabs = [Tab(text: 'A'), Tab(text: 'B')];

      await tester.pumpWidget(
        _wrapWithTabController(
          tabs: tabs,
          child: const LeafTabBar(
            tabs: tabs,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.indicatorSize, TabBarIndicatorSize.label);
    });
  });

  group('LeafTabView', () {
    testWidgets('renders children', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(tabs: [Tab(text: 'A'), Tab(text: 'B')]),
                Expanded(
                  child: LeafTabView(
                    children: [
                      const Text('Content 1'),
                      const Text('Content 2'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Content 1'), findsOneWidget);
    });
  });
}
