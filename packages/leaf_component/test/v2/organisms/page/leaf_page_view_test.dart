import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  final pages = [
    const SizedBox(height: 100, child: Text('Page 1')),
    const SizedBox(height: 100, child: Text('Page 2')),
    const SizedBox(height: 100, child: Text('Page 3')),
  ];

  group('LeafPageView', () {
    testWidgets('renders first page', (tester) async {
      await tester.pumpWidget(wrapWithTheme(LeafPageView(children: pages)));
      await tester.pumpAndSettle();

      expect(find.text('Page 1'), findsOneWidget);
    });

    testWidgets('shows indicator by default', (tester) async {
      await tester.pumpWidget(wrapWithTheme(LeafPageView(children: pages)));
      await tester.pumpAndSettle();

      expect(find.byType(LeafPageRectIndicator), findsOneWidget);
    });

    testWidgets('hides indicator when showIndicator is false', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LeafPageView(showIndicator: false, children: pages)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LeafPageRectIndicator), findsNothing);
    });

    testWidgets('fires onPageChanged callback', (tester) async {
      double? pageValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafPageView(
            children: pages,
            onPageChanged: (value) => pageValue = value,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Swipe left to go to page 2
      await tester.drag(find.byType(LeafPageView), const Offset(-400.0, 0.0));
      await tester.pumpAndSettle();

      expect(pageValue, isNotNull);
    });

    testWidgets('uses custom indicatorBuilder', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafPageView(
            children: pages,
            indicatorBuilder: (total, current) {
              return Text('$total pages');
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('3 pages'), findsOneWidget);
      expect(find.byType(LeafPageRectIndicator), findsNothing);
    });

    testWidgets('applies padding and margin', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafPageView(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(4.0),
            children: pages,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.padding, const EdgeInsets.all(8.0));
      expect(container.margin, const EdgeInsets.all(4.0));
    });

    testWidgets('uses theme colors for indicator', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        pageViewTheme: const LeafPageViewThemeData(
          indicatorActiveColor: Colors.purple,
          indicatorInactiveColor: Colors.grey,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(LeafPageView(children: pages), theme: theme),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LeafPageRectIndicator), findsOneWidget);
    });

    testWidgets('explicit indicator colors override theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        pageViewTheme: const LeafPageViewThemeData(
          indicatorActiveColor: Colors.purple,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LeafPageView(indicatorActiveColor: Colors.orange, children: pages),
          theme: theme,
        ),
      );
      await tester.pumpAndSettle();

      // The widget renders with the override; verify by finding the indicator
      final indicator = tester.widget<LeafPageRectIndicator>(
        find.byType(LeafPageRectIndicator),
      );
      expect(indicator.activeColor, Colors.orange);
    });

    testWidgets('starts at initialPage', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(LeafPageView(initialPage: 1, children: pages)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Page 2'), findsOneWidget);
    });
  });
}
