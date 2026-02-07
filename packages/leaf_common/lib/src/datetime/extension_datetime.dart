import 'leaf_date.dart';

extension LeafDateDateTime on DateTime {
  bool isToday() {
    final today = LeafDate.now().dateTime;
    return isSameDateTime(today, onlyDate: true);
  }

  bool isSameDateTime(DateTime other, {bool onlyDate = false}) {
    if (onlyDate) {
      return year == other.year && month == other.month && day == other.day;
    }
    return compareTo(other) == 0;
  }

  DateTime addMonths(int months) {
    final newMonth = month + months;
    final newYear = year + (newMonth - 1) ~/ 12;
    final normalizedMonth = ((newMonth - 1) % 12) + 1;
    var newDay = day;
    final lastDayOfMonth = DateTime(newYear, normalizedMonth + 1, 0).day;
    if (newDay > lastDayOfMonth) {
      newDay = lastDayOfMonth;
    }
    return DateTime(newYear, normalizedMonth, newDay, hour, minute, second,
        millisecond, microsecond);
  }
}
