import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_leaf_component/src/v2/component/calendar/date/extension_calendar_v2.dart';

void main() {
  group('DateCalendarV2', () {
    test('daysInMonthGrid returns 42 elements', () {
      final date = DateTime(2024, 3, 15);
      final grid = date.daysInMonthGrid();
      expect(grid.length, 42);
    });

    test('daysInMonthGrid starts on a Sunday', () {
      final date = DateTime(2024, 3); // March 2024, starts on Friday
      final grid = date.daysInMonthGrid();
      // The first element should be a Sunday (weekday 7 in Dart)
      expect(grid.first.weekday, 7); // Sunday
    });

    test('daysInMonthGrid contains all days of the month', () {
      final date = DateTime(2024, 2); // Feb 2024 (leap year, 29 days)
      final grid = date.daysInMonthGrid();
      final febDays =
          grid.where((d) => d.month == 2 && d.year == 2024).toList();
      expect(febDays.length, 29);
    });

    test('isSameDay returns true for same date', () {
      final a = DateTime(2024, 3, 15, 10, 30);
      final b = DateTime(2024, 3, 15, 22, 0);
      expect(a.isSameDay(b), isTrue);
    });

    test('isSameDay returns false for different date', () {
      final a = DateTime(2024, 3, 15);
      final b = DateTime(2024, 3, 16);
      expect(a.isSameDay(b), isFalse);
    });

    test('isToday returns true for today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day, 8, 0);
      expect(today.isToday, isTrue);
    });

    test('isToday returns false for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isToday, isFalse);
    });

    test('toYearMonthString formats correctly', () {
      expect(DateTime(2024, 3).toYearMonthString(), '2024.03');
      expect(DateTime(2024, 12).toYearMonthString(), '2024.12');
    });
  });
}
