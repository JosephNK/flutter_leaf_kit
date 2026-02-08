import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafBottomSheet', () {
    final items = [
      const LeafBottomSheetItem<String>(key: 'a', title: 'Option A'),
      const LeafBottomSheetItem<String>(key: 'b', title: 'Option B'),
      const LeafBottomSheetItem<String>(key: 'c', title: 'Option C'),
    ];

    testWidgets('shows material bottom sheet with items', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafBottomSheet.show<String>(context, items: items);
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
      expect(find.text('Option C'), findsOneWidget);
    });

    testWidgets('calls onTap when item is tapped', (tester) async {
      LeafBottomSheetItem<String>? tappedItem;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafBottomSheet.show<String>(
                    context,
                    items: items,
                    onTap: (item) => tappedItem = item,
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Option B'));
      await tester.pumpAndSettle();

      expect(tappedItem?.key, 'b');
    });

    testWidgets('uses theme colors as fallback', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        bottomSheetTheme: const LeafBottomSheetThemeData(
          activeColor: Colors.red,
          inactiveColor: Colors.grey,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafBottomSheet.show<String>(
                    context,
                    items: items,
                    selectedItem: items.first,
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
          theme: theme,
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('calls onClose when bottom sheet is dismissed', (tester) async {
      bool closed = false;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafBottomSheet.show<String>(
                    context,
                    items: items,
                    onClose: () => closed = true,
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Dismiss by tapping the barrier
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    });

    testWidgets('LeafBottomSheetItem model holds correct values', (_) async {
      const item = LeafBottomSheetItem<int>(
        key: 42,
        title: 'Test Item',
        enabled: false,
      );

      expect(item.key, 42);
      expect(item.title, 'Test Item');
      expect(item.enabled, isFalse);
    });
  });
}
