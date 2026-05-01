import 'package:flutter/material.dart';
import 'package:flutter_leaf_core/leaf_core.dart';

/// Private Extension

extension on int {
  Duration get daysDuration => Duration(days: (this == 7) ? 0 : -this);
}

extension on DateTime {
  // Magic const: 12 is to maintain compatibility with date_utils
  DateTime get middayDateTimeUTC =>
      LeafDate.parseFromList([year, month, day, 12, 0, 0]).toUtc();
}

/// Public Extension

@Deprecated('Use LeafCalendarView instead')
extension DateCalendar on DateTime {
  List<DateTime> daysInMonth() {
    final date = this;
    final result = <DateTime>[];
    final firstDayOfTheMonth = LeafDate.parseFromList([
      date.year,
      date.month,
      1,
    ]).dateTime;
    final firstDay = firstDayOfTheMonth.add(
      firstDayOfTheMonth.weekday.daysDuration,
    );
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

@Deprecated('Use LeafCalendarView instead')
extension DateCalendar1 on DateTime {
  DateTime toCalDayStartDateTime() {
    final dateString = toCalYearMonthDayString();
    return LeafDate.parseFromString('$dateString 00:00:00').dateTime;
  }

  DateTime toCalDayEndDateTime() {
    final dateString = toCalYearMonthDayString();
    return LeafDate.parseFromString('$dateString 23:59:59').dateTime;
  }

  String toCalYearMonthDayHourMinuteString() {
    return LeafDate.parseFromDateTime(this).format('yyyy-MM-dd HH:mm');
  }

  String toCalYearMonthDayString() {
    return LeafDate.parseFromDateTime(this).format('yyyy-MM-dd');
  }

  String toCalHHmmString() {
    return LeafDate.parseFromDateTime(this).format('HH:mm');
  }

  String toCalYearString() {
    return LeafDate.parseFromDateTime(this).format('yyyy');
  }

  String toCalMonthString() {
    return LeafDate.parseFromDateTime(this).format('MM');
  }

  String toCalDayString() {
    return LeafDate.parseFromDateTime(this).format('dd');
  }

  String toCalLunarDateString() {
    return LeafDate.parseFromDateTime(this).toLunarFormat('yyyy-MM-dd');
  }

  String toCalSolarDateString() {
    return LeafDate.parseFromDateTime(
      this,
    ).toSolarFromLunarFormat('yyyy-MM-dd');
  }

  String toCalMeridiemTimeString(BuildContext context) {
    DateFormat? formatter;
    try {
      final languageCode = Localizations.localeOf(context).languageCode;
      if (languageCode == 'ko') {
        formatter = DateFormat('aa hh:mm', 'ko');
      }
    } catch (e) {
      debugPrint('toCalMeridiemTimeString error: $e');
    }
    formatter ??= DateFormat('hh:mm aa', 'en');
    return formatter.format(this);
  }

  String toCalWeekDayDateString(
    BuildContext context, {
    bool showTime = false,
    bool short = false,
    bool isLunar = false,
    bool visiblePrefix = false,
  }) {
    DateFormat formatLocaleYearMonthDay(BuildContext context) {
      try {
        final languageCode = Localizations.localeOf(context).languageCode;
        if (languageCode == 'ko') {
          return DateFormat('yyyy년 MM월 dd일', 'ko');
        }
      } catch (e) {
        debugPrint('formatLocaleYearMonthDay error: $e');
      }
      return DateFormat('yyyy.MM.dd', 'en');
    }

    DateFormat formatLocaleWeekDay(BuildContext context) {
      try {
        final locale = Localizations.localeOf(context);
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

    final languageCode = Localizations.localeOf(context).languageCode;
    String prefix = !isLunar
        ? (languageCode == 'ko' ? '양' : 'Solar')
        : (languageCode == 'ko' ? '음' : 'Lunar');
    DateTime? dateTime = !isLunar
        ? this
        : LeafDate.parseFromString(
            LeafDate.parseFromDateTime(this).toLunarFormat('yyyy-MM-dd'),
          ).dateTime;
    String dateStr = formatLocaleYearMonthDay(context).format(dateTime);
    String weekDayStr = formatLocaleWeekDay(context).format(dateTime);
    if (short) {
      dateStr = toNormalDateDisplay(dateTime); // ex., 2023.01.01
    }

    String result = '$dateStr ($weekDayStr)';
    if (showTime) {
      String timeStr = toCalMeridiemTimeString(context);
      result = '$dateStr $timeStr ($weekDayStr)';
    }
    return visiblePrefix ? '$prefix $result' : result;
  }
}
