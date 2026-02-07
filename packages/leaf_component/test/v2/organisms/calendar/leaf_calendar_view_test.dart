import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_leaf_component/src/v2/organisms/calendar/controller/leaf_calendar_controller.dart';
import 'package:flutter_leaf_component/src/v2/organisms/calendar/widget/leaf_calendar_view.dart';

import '../../../helpers/theme_test_helper.dart';

/// Wraps [calendar] in a scrollable container so it does not overflow in
/// the 800×600 test viewport.
Widget _wrap(Widget calendar) {
  return wrapWithTheme(SingleChildScrollView(child: calendar));
}

void main() {
  group('LeafCalendarView', () {
    testWidgets('renders month label for default date', (tester) async {
      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 15),
            onMonthChanged: (_, _) {},
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2024.03'), findsOneWidget);
    });

    testWidgets('renders weekday headers', (tester) async {
      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            onMonthChanged: (_, _) {},
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sun'), findsOneWidget);
      expect(find.text('Mon'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
    });

    testWidgets('displays day numbers in the grid', (tester) async {
      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            onMonthChanged: (_, _) {},
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1'), findsWidgets);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('tapping a date fires onDateSelected', (tester) async {
      DateTime? selected;

      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            onMonthChanged: (_, _) {},
            onDateSelected: (date) {
              selected = date;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
      expect(selected!.day, 15);
      expect(selected!.month, 3);
    });

    testWidgets('prev/next arrows navigate months', (tester) async {
      DateTime? changedMonth;

      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            onMonthChanged: (month, _) {
              changedMonth = month;
            },
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_forward_ios));
      await tester.pumpAndSettle();

      expect(changedMonth, isNotNull);
      expect(changedMonth!.month, 4);
      expect(find.text('2024.04'), findsOneWidget);
    });

    testWidgets('controller goToToday jumps to today', (tester) async {
      final controller = LeafCalendarController();
      DateTime? selected;

      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2020, 1, 1),
            controller: controller,
            onMonthChanged: (_, _) {},
            onDateSelected: (d) {
              selected = d;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2020.01'), findsOneWidget);

      controller.goToToday();
      await tester.pumpAndSettle();

      final now = DateTime.now();
      final expectedLabel =
          '${now.year}.${now.month.toString().padLeft(2, '0')}';
      expect(find.text(expectedLabel), findsOneWidget);
      expect(selected, isNotNull);
      expect(selected!.day, now.day);

      controller.dispose();
    });

    testWidgets('custom weekdays are rendered', (tester) async {
      const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            weekdays: weekdays,
            onMonthChanged: (_, _) {},
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('일'), findsOneWidget);
      expect(find.text('토'), findsOneWidget);
    });

    testWidgets('has Semantics label for accessibility', (tester) async {
      await tester.pumpWidget(
        _wrap(
          LeafCalendarView(
            defaultDate: DateTime(2024, 3, 1),
            onMonthChanged: (_, _) {},
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final semantics = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .where((s) => s.properties.label == 'Calendar');
      expect(semantics, isNotEmpty);
    });
  });
}
