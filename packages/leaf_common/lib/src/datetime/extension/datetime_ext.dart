part of '../../lf_common.dart';

/// https://www.flutterbeads.com/format-datetime-in-flutter/

extension DateTimeString on DateTime {
  String toDateTimeIso8601() {
    DateTime localDateTime = toLocal();
    String formattedDateTime = localDateTime.toUtc().toIso8601String();
    return formattedDateTime;
  }

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
    late String value;
    value = LFDateTime.shared.formatDate(this, format: format);
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

  String toLunarDateString({
    String format = 'yyyy-MM-dd',
    bool showShortLunar = false,
  }) {
    // param : year(년), month(월), day(일)
    setSolarDate(year, month, day);
    final lunar = getLunarIsoFormat();
    final value = LFDateTime.shared.formatString(lunar, format: format);
    final prefix = LFLocalizations.shared.localization.shortLunar;
    if (showShortLunar) {
      return '$prefix $value';
    }
    return value;
  }

  String toSolarDateString({
    String format = 'yyyy-MM-dd',
    bool showShortSolar = false,
  }) {
    // param : year(년), month(월), day(일), intercalation(윤달여부)
    setLunarDate(year, month, day, false);
    final solar = getSolarIsoFormat();
    final value = LFDateTime.shared.formatString(solar, format: format);
    final prefix = LFLocalizations.shared.localization.shortSolar;
    if (showShortSolar) {
      return '$prefix $value';
    }
    return value;
  }

  String toNormalDateDisplay() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
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

  String toMeridiemTimeString() {
    final formatter = LFDateTime.shared.formatLocaleMeridiemTime();
    return formatter.format(this);
  }

  String toWeekDayDateString({
    bool showTime = false,
    bool short = false,
    bool isLunar = false,
    bool visiblePrefix = false,
  }) {
    String format = 'yyyy-MM-dd';
    String prefix = !isLunar
        ? LFLocalizations.shared.localization.shortSolar
        : LFLocalizations.shared.localization.shortLunar;
    DateTime? dateTime =
        !isLunar ? this : LFDateTime.parse(toLunarDateString(format: format));
    String dateStr =
        LFDateTime.shared.formatLocaleYearMonthDay().format(dateTime);
    String weekDayStr =
        LFDateTime.shared.formatLocaleWeekDay().format(dateTime);
    if (short) {
      dateStr = dateTime.toNormalDateDisplay(); // ex., 2023.01.01
    }

    String result = '$dateStr ($weekDayStr)';

    if (showTime) {
      String timeStr = toMeridiemTimeString();
      result = '$dateStr $timeStr ($weekDayStr)';
    }

    return visiblePrefix ? '$prefix $result' : result;
  }

  DateTime toDayStartDateTime() {
    final dateString = LFDateTime.shared.formatDate(this, format: 'yyyy-MM-dd');
    return LFDateTime.parse('$dateString 00:00:00');
  }

  DateTime toDayEndDateTime() {
    final dateString = LFDateTime.shared.formatDate(this, format: 'yyyy-MM-dd');
    return LFDateTime.parse('$dateString 23:59:59');
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

  String toAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inMinutes < 1) {
      return LFLocalizations.shared.localization.nowAgo;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} ${LFLocalizations.shared.localization.min} ${LFLocalizations.shared.localization.ago}';
    } else if (difference.inHours < 23) {
      return '${difference.inHours} ${LFLocalizations.shared.localization.hour} ${LFLocalizations.shared.localization.ago}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${LFLocalizations.shared.localization.day} ${LFLocalizations.shared.localization.ago}';
    }
    return toLongDateTimeString();
  }

  int weekNumber() {
    int weekNumber = ((day - 1) ~/ 7) + 1;
    return weekNumber;
  }

  int timestamp() {
    return millisecondsSinceEpoch;
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

  DateTime firstDayInMonth() {
    return daysInMonth().first;
  }

  DateTime lastDayInMonth() {
    return daysInMonth().last;
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

  DateTime toTimestamp({int? addition}) {
    if (addition != null) {
      return DateTime.fromMillisecondsSinceEpoch(this * addition);
    }
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  bool isSameDate(int p2) {
    return timeToDate.compareTo(p2.timeToDate) == 0;
  }

  bool isSameDateTime(int p2) {
    return timeToDateTime.compareTo(p2.timeToDateTime) == 0;
  }
}
