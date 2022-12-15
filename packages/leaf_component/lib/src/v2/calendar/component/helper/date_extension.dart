part of lf_calendar_view;

extension DateExtension on int {
  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }
}

extension DateTimeExtension on DateTime {
  DateTime firstDayOfWeek() {
    var day = createUTCMiddayDateTime();
    return day.subtract(Duration(days: weekday % 7));
  }

  DateTime lastDayOfWeek() {
    var day = createUTCMiddayDateTime();
    return day.add(Duration(days: 7 - day.weekday % 7));
  }

  DateTime createUTCMiddayDateTime() {
    // Magic const: 12 is to maintain compatibility with date_utils
    return DateTime.utc(year, month, day, 12, 0, 0);
  }

  String formatDate({String format = 'yyyy.MM.dd HH:mm'}) {
    return DateFormat(format).format(this);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension DateTimeBoolExtenstion on DateTime {
  bool isToday() {
    final today = DateTime.now();
    final isToday =
        (today.year == year) && (today.month == month) && (today.day == day);
    return isToday;
  }

  List<DateTime> daysInMonth() {
    final date = this;
    final result = <DateTime>[];
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    final firstDay =
        firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
    result.add(firstDay);
    for (var i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }
}
