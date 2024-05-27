import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_datetime/leaf_datetime.dart';

/// Private Extension

extension on int {
  Duration get daysDuration => Duration(days: (this == 7) ? 0 : -this);
}

extension on DateTime {
  // Magic const: 12 is to maintain compatibility with date_utils
  DateTime get middayDateTimeUTC =>
      LFDate.parseFromList([year, month, day, 12, 0, 0]).toUtc();
}

/// Public Extension

extension DateCalendar on DateTime {
  List<DateTime> daysInMonth() {
    final date = this;
    final result = <DateTime>[];
    final firstDayOfTheMonth =
        LFDate.parseFromList([date.year, date.month, 1]).dateTime;
    final firstDay =
        firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
    result.add(firstDay);
    for (var i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime inMonth() {
    return middayDateTimeUTC;
  }

  DateTime firstDayOfWeek() {
    var day = middayDateTimeUTC;
    return day.subtract(Duration(days: weekday % 7));
  }

  DateTime lastDayOfWeek() {
    var day = middayDateTimeUTC;
    return day.add(Duration(days: 7 - day.weekday % 7));
  }

  DateTime firstDayInMonth() {
    return daysInMonth().first;
  }

  DateTime lastDayInMonth() {
    return daysInMonth().last;
  }

// String toDateTimeIso8601() {
//   DateTime localDateTime = toLocal();
//   String formattedDateTime = localDateTime.toUtc().toIso8601String();
//   return formattedDateTime;
// }
}

extension DateCalendar1 on DateTime {
  DateTime toCalDayStartDateTime() {
    final dateString = toCalYearMonthDayString();
    return LFDate.parseFromString('$dateString 00:00:00').dateTime;
  }

  DateTime toCalDayEndDateTime() {
    final dateString = toCalYearMonthDayString();
    return LFDate.parseFromString('$dateString 23:59:59').dateTime;
  }

  String toCalYearMonthDayHourMinuteString() {
    return LFDate.parseFromDateTime(this).format('yyyy-MM-dd HH:mm');
  }

  String toCalYearMonthDayString() {
    return LFDate.parseFromDateTime(this).format('yyyy-MM-dd');
  }

  String toCalHHmmString() {
    return LFDate.parseFromDateTime(this).format('HH:mm');
  }

  String toCalYearString() {
    return LFDate.parseFromDateTime(this).format('yyyy');
  }

  String toCalMonthString() {
    return LFDate.parseFromDateTime(this).format('MM');
  }

  String toCalDayString() {
    return LFDate.parseFromDateTime(this).format('dd');
  }

  String toCalLunarDateString() {
    return LFDate.parseFromDateTime(this).toLunarFormat('yyyy-MM-dd');
  }

  String toCalSolarDateString() {
    return LFDate.parseFromDateTime(this).toSolarFromLunarFormat('yyyy-MM-dd');
  }

  String toCalMeridiemTimeString() {
    DateFormat? formatter;
    try {
      if (LFLocalizations.shared.languageCode == 'ko') {
        formatter = DateFormat('aa hh:mm', 'ko');
      }
    } catch (e) {
      debugPrint('toCalMeridiemTimeString error: $e');
    }
    formatter ??= DateFormat('hh:mm aa', 'en');
    return formatter.format(this);
  }

  String toCalWeekDayDateString({
    bool showTime = false,
    bool short = false,
    bool isLunar = false,
    bool visiblePrefix = false,
  }) {
    DateFormat formatLocaleYearMonthDay() {
      try {
        final languageCode = LFLocalizations.shared.languageCode;
        if (languageCode == 'ko') {
          final yearUnit = LFLocalizations.shared.localization.year;
          final monthUnit = LFLocalizations.shared.localization.month;
          final dayUnit = LFLocalizations.shared.localization.day;
          return DateFormat('yyyy$yearUnit MM$monthUnit dd$dayUnit', 'ko');
        }
      } catch (e) {
        debugPrint('formatLocaleYearMonthDay error: $e');
      }
      return DateFormat('yyyy.MM.dd', 'en');
    }

    DateFormat formatLocaleWeekDay() {
      try {
        final locale = LFLocalizations.shared.locale.toString();
        return DateFormat.E(locale);
      } catch (e) {
        debugPrint('formatLocaleWeekDay error: $e');
      }
      return DateFormat.E('en_US');
    }

    String toNormalDateDisplay(DateTime dateTime) {
      final year = dateTime.year.toString().padLeft(4, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final day = dateTime.day.toString().padLeft(2, '0');
      return '$year.$month.$day';
    }

    String prefix = !isLunar
        ? LFLocalizations.shared.localization.shortSolar
        : LFLocalizations.shared.localization.shortLunar;
    DateTime? dateTime = !isLunar
        ? this
        : LFDate.parseFromString(
            LFDate.parseFromDateTime(this).toLunarFormat('yyyy-MM-dd'),
          ).dateTime;
    String dateStr = formatLocaleYearMonthDay().format(dateTime);
    String weekDayStr = formatLocaleWeekDay().format(dateTime);
    if (short) {
      dateStr = toNormalDateDisplay(dateTime); // ex., 2023.01.01
    }

    String result = '$dateStr ($weekDayStr)';
    if (showTime) {
      String timeStr = toCalMeridiemTimeString();
      result = '$dateStr $timeStr ($weekDayStr)';
    }
    return visiblePrefix ? '$prefix $result' : result;
  }
}
