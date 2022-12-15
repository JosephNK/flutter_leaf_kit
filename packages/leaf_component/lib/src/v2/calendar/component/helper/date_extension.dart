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

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime previousMonth() {
    return DateTime(year, month - 1, day);
  }

  DateTime nextMonth() {
    return DateTime(year, month + 1, day);
  }

  String getMonthString() {
    switch (month) {
      case 1:
        return 'Jan.';
      case 2:
        return 'Feb.';
      case 3:
        return 'Mar.';
      case 4:
        return 'Apr.';
      case 5:
        return 'May';
      case 6:
        return 'Jun.';
      case 7:
        return 'Jul.';
      case 8:
        return 'Aug.';
      case 9:
        return 'Sept.';
      case 10:
        return 'Oct.';
      case 11:
        return 'Nov.';
      case 12:
        return 'Dec.';
      default:
        return 'Err';
    }
  }
}
