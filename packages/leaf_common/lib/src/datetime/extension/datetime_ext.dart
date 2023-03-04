part of lf_common;

extension DateTimeString on DateTime {
  String toLongDateTime() {
    return LFDateTime.shared.formatDate(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LFDateTime.shared.formatDate(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LFDateTime.shared.formatDate(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LFDateTime.shared.formatDate(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LFDateTime.shared.formatDate(this, format: 'MM.dd');
  }

  String toYear() {
    return LFDateTime.shared.formatDate(this, format: 'yyyy');
  }

  String toMonth() {
    return LFDateTime.shared.formatDate(this, format: 'MM');
  }

  String toDay() {
    return LFDateTime.shared.formatDate(this, format: 'dd');
  }

  String toTime() {
    return LFDateTime.shared.formatDate(this, format: 'HH:mm');
  }

  String toLocaleHHmmTime() {
    return millisecondsSinceEpoch.toLocaleHHmmTime();
  }

  String toLocaleYearMonthDayWeekDate() {
    return millisecondsSinceEpoch.toLocaleYearMonthDayWeekDate();
  }

  DateTime to000000Time() {
    return DateTime.parse(
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} 00:00:00');
  }

  DateTime to235959Time() {
    return DateTime.parse(
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} 23:59:59');
  }
}

extension DateTimeDiff on DateTime {
  int diffMinutes(DateTime dateTime) {
    return difference(dateTime).inMinutes;
  }

  int diffSeconds(DateTime dateTime) {
    return difference(dateTime).inSeconds;
  }
}

extension DateTimeCalendar on DateTime {
  DateTime inMonth() {
    var day = createUTCMiddayDateTime();
    return day;
  }

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
    final today = LFDateTime.today();
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

extension DateExtension on int {
  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }

  DateTime get timeToDate {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  DateTime get timeToDateTime {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
        dateTime.minute);
  }

  String toLocaleHHmmTime() {
    // TODO: Set Locale
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    final DateFormat formatter = DateFormat('aa hh:mm', 'ko');
    return formatter.format(dateTime);
  }

  String toLocaleYearMonthDayWeekDate() {
    // TODO: Set Locale
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    final weekDay = DateFormat.EEEE('ko_KR').format(dateTime);
    final yearUnit = LFDateTime.shared.localization.year;
    final monthUnit = LFDateTime.shared.localization.month;
    final dayUnit = LFDateTime.shared.localization.day;
    return '${dateTime.year}$yearUnit ${dateTime.month}$monthUnit ${dateTime.day}$dayUnit $weekDay';
  }

  bool isSameDate(int p2) {
    return timeToDate.compareTo(p2.timeToDate) == 0;
  }

  bool isSameDateTime(int p2) {
    return timeToDateTime.compareTo(p2.timeToDateTime) == 0;
  }
}
