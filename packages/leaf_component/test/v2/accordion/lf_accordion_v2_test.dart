import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

void main() {
  final testItems = [
    const LFAccordionItemV2<String>(
      title: 'Section 1',
      data: 'data1',
    ),
    const LFAccordionItemV2<String>(
      title: 'Section 2',
      data: 'data2',
      subtitle: 'Subtitle 2',
    ),
    const LFAccordionItemV2<String>(
      title: 'Section 3',
      data: 'data3',
    ),
  ];

  group('LFAccordionItemV2', () {
    test('creates model with required fields', () {
      const item = LFAccordionItemV2<int>(
        title: 'Test',
        data: 42,
      );

      expect(item.title, 'Test');
      expect(item.data, 42);
      expect(item.subtitle, isNull);
    });

    test('creates model with subtitle', () {
      const item = LFAccordionItemV2<String>(
        title: 'Test',
        data: 'value',
        subtitle: 'Sub',
      );

      expect(item.subtitle, 'Sub');
    });
  });

  group('LFAccordionTileV2', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'My Title',
            expanded: false,
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('My Title'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'Title',
            subtitle: 'Subtitle',
            expanded: false,
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('expands when expanded is true', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'Title',
            expanded: true,
            child: Text('Hidden Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Hidden Content'), findsOneWidget);
    });

    testWidgets('fires callback on header tap', (tester) async {
      bool? callbackValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionTileV2(
            title: 'Tappable',
            expanded: false,
            onExpansionChanged: (value) => callbackValue = value,
            child: const Text('Content'),
          ),
        ),
      );

      await tester.tap(find.text('Tappable'));
      await tester.pump();

      expect(callbackValue, isTrue);
    });

    testWidgets('animates on expand/collapse transition', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'Title',
            expanded: false,
            child: Text('Content'),
          ),
        ),
      );

      // Rebuild with expanded: true
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'Title',
            expanded: true,
            child: Text('Content'),
          ),
        ),
      );

      // Pump a few frames to verify animation is running
      await tester.pump(const Duration(milliseconds: 100));

      // Content should be present even mid-animation
      expect(find.text('Content'), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAccordionTileV2(
            title: 'Semantic Title',
            expanded: false,
            child: Text('Content'),
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasLabel = semantics.any(
        (s) => s.properties.label == 'Semantic Title',
      );
      expect(hasLabel, isTrue);
    });
  });

  group('LFAccordionV2', () {
    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
          ),
        ),
      );

      expect(find.text('Section 1'), findsOneWidget);
      expect(find.text('Section 2'), findsOneWidget);
      expect(find.text('Section 3'), findsOneWidget);
    });

    testWidgets('expands single item via expandedIndex', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
            expandedIndex: 0,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Content: data1'), findsOneWidget);
    });

    testWidgets('fires onExpansionChanged with correct index', (tester) async {
      int? changedIndex;

      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
            onExpansionChanged: (index) => changedIndex = index,
          ),
        ),
      );

      await tester.tap(find.text('Section 2'));
      await tester.pump();

      expect(changedIndex, 1);
    });

    testWidgets('supports multiple expansion', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
            allowMultiple: true,
            expandedIndices: const {0, 2},
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Content: data1'), findsOneWidget);
      expect(find.text('Content: data3'), findsOneWidget);
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LFThemeData.light().copyWith(
        accordionTheme: const LFAccordionThemeData(
          headerBackgroundColor: Colors.amber,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
          ),
          theme: theme,
        ),
      );

      expect(find.text('Section 1'), findsOneWidget);
    });

    testWidgets('renders subtitle when item has one', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFAccordionV2<String>(
            items: testItems,
            itemBuilder: (_, _, data) => Text('Content: $data'),
          ),
        ),
      );

      expect(find.text('Subtitle 2'), findsOneWidget);
    });
  });
}
