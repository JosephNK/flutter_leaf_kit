/// Date utility extensions for the V2 Calendar system.
///
/// Provides helpers for generating month day grids, checking "today",
/// and same-day comparison — all without relying on leaf_datetime.
extension DateCalendarV2 on DateTime {
  /// Returns a 42-element list (6 weeks × 7 days) starting from the Sunday
  /// of the week that contains the first day of [this] month.
  List<DateTime> daysInMonthGrid() {
    final firstOfMonth = DateTime(year, month, 1);
    // weekday: Monday=1 … Sunday=7.  Convert so Sunday=0.
    final offsetFromSunday = firstOfMonth.weekday % 7;
    final gridStart = firstOfMonth.subtract(Duration(days: offsetFromSunday));

    return List<DateTime>.generate(
      42,
      (i) => DateTime(gridStart.year, gridStart.month, gridStart.day + i),
    );
  }

  /// Whether [this] represents the same calendar date as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Whether [this] is today in local time.
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  /// Year-month string e.g. "2024.03".
  String toYearMonthString() {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    return '$y.$m';
  }
}
