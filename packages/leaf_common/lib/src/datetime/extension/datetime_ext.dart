part of lf_common;

/// https://www.flutterbeads.com/format-datetime-in-flutter/

extension DateTimeString on DateTime {
  String toDateTimeString({String format = 'yyyy-MM-dd HH:mm'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toLongDateTimeString({String format = 'yyyy.MM.dd HH:mm'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toShortDateTimeString({String format = 'yyyy.MM.dd'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toDateString({String format = 'MM.dd', bool showWeekDay = false}) {
    final value = LFDateTime.shared.formatDate(this, format: format);
    if (showWeekDay) {
      final weekDay = toWeekDay(short: true);
      return '$value($weekDay)';
    }
    return value;
  }

  String toYearString({String format = 'yyyy'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toMonthString({String format = 'MM'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toDayString({String format = 'dd'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toTimeString({String format = 'HH:mm'}) {
    return LFDateTime.shared.formatDate(this, format: format);
  }

  String toLunarDateString({String format = 'yyyy-MM-dd'}) {
    // param : year(년), month(월), day(일)
    setSolarDate(year, month, day);
    final lunar = getLunarIsoFormat();
    return LFDateTime.shared.formatString(lunar, format: format);
  }

  String toSolarDateString({String format = 'yyyy-MM-dd'}) {
    // param : year(년), month(월), day(일), intercalation(윤달여부)
    setLunarDate(year, month, day, false);
    final solar = getSolarIsoFormat();
    return LFDateTime.shared.formatString(solar, format: format);
  }

  String toWeekDay({bool short = true}) {
    String weekDay = '';
    try {
      if (short) {
        weekDay = DateFormat.E('ko_KR').format(this);
      } else {
        weekDay = DateFormat.EEEE('ko_KR').format(this);
      }
    } catch (_) {}
    return weekDay;
  }

  String toAAHHmmTimeString() {
    return millisecondsSinceEpoch.toAAHHmmTime();
  }

  String toYMMDWDateString({bool showUnit = true}) {
    return millisecondsSinceEpoch.toYMMDWDate(showUnit: showUnit);
  }

  DateTime to000000Time() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return DateTime.parse('$year-$month-$day 00:00:00');
  }

  DateTime to235959Time() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return DateTime.parse('$year-$month-$day 23:59:59');
  }
}

extension DateTimeCompare on DateTime {
  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isBetween(DateTime fromDateTime, DateTime toDateTime,
      {bool equal = true}) {
    final date = this;
    if (equal) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime);
      final isBefore = date.isBeforeOrEqualTo(toDateTime);
      return isAfter && isBefore;
    }
    final isAfter = date.isAfter(fromDateTime);
    final isBefore = date.isBefore(toDateTime);
    return isAfter && isBefore;
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
    final dateTime = toTimestamp();
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  DateTime get timeToDateTime {
    final dateTime = toTimestamp();
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
        dateTime.minute);
  }

  DateTime toTimestamp() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  String toAAHHmmTime() {
    // TODO: Set Locale
    final dateTime = toTimestamp();
    final DateFormat formatter = DateFormat('aa hh:mm', 'ko');
    return formatter.format(dateTime);
  }

  String toYMMDWDate({bool showUnit = true}) {
    // TODO: Set Locale
    final dateTime = toTimestamp();
    //final weekDay = DateFormat.EEEE('ko_KR').format(dateTime);
    final weekDay = DateFormat.E('ko_KR').format(dateTime);
    final yearUnit = LFDateTime.shared.localization.year;
    final monthUnit = LFDateTime.shared.localization.month;
    final dayUnit = LFDateTime.shared.localization.day;
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    if (showUnit) {
      return '$year$yearUnit $month$monthUnit $day$dayUnit ($weekDay)';
    }
    return '$year.$month.$day ($weekDay)';
  }

  bool isSameDate(int p2) {
    return timeToDate.compareTo(p2.timeToDate) == 0;
  }

  bool isSameDateTime(int p2) {
    return timeToDateTime.compareTo(p2.timeToDateTime) == 0;
  }
}
