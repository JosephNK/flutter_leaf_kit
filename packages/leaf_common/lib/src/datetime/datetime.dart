part of lf_common;

class LFDateTime {
  static final LFDateTime _instance = LFDateTime._internal();

  static LFDateTime get shared => _instance;

  LFDateTime._internal();

  static DateTime parse(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static DateTime today() {
    return DateTime.now();
  }

  static String todayString({
    String format = 'yyyy-MM-dd HH:mm:ss',
  }) {
    return DateFormat(format).format(today());
  }

  DateTime dateToLocalTimeStampTZ(String value,
      {int multiply = 1, bool isLocal = true}) {
    late DateTime dateTime;

    final timeStamp = int.tryParse(value) ?? 0;
    if (timeStamp != 0) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1);
    } else {
      try {
        dateTime = (value.contains('Z'))
            ? DateTime.parse(value)
            : DateTime.parse('${value}Z');
      } catch (_) {
        try {
          dateTime = DateTime.parse(value);
        } catch (_) {
          dateTime = DateTime.now();
        }
      }
    }

    if (isLocal) {
      return dateTime.toLocal();
    }
    return dateTime;
  }

  String formatString(
    String value, {
    String format = 'yyyy.MM.dd HH:mm',
  }) {
    if (isEmpty(value)) return '0000.00.00 00:00';
    final dateTimeToLocal = dateToLocalTimeStampTZ(value);
    return DateFormat(format).format(dateTimeToLocal);
  }

  String formatDate(
    DateTime value, {
    String format = 'yyyy.MM.dd HH:mm',
  }) {
    return DateFormat(format).format(value);
  }

  DateFormat formatLocaleYearMonthDay() {
    try {
      final languageCode = LFLocalizations.shared.languageCode;
      if (languageCode == 'ko') {
        final yearUnit = LFLocalizations.shared.localization.year;
        final monthUnit = LFLocalizations.shared.localization.month;
        final dayUnit = LFLocalizations.shared.localization.day;
        return DateFormat('yyyy$yearUnit MM$monthUnit dd$dayUnit', 'ko');
      }
      return DateFormat('yyyy.MM.dd', 'en');
    } catch (e) {
      debugPrint('DateFormat Locale error: $e');
      return DateFormat('yyyy.MM.dd', 'en');
    }
  }

  DateFormat formatLocaleMeridiemTime() {
    try {
      final languageCode = LFLocalizations.shared.languageCode;
      if (languageCode == 'ko') {
        return DateFormat('aa hh:mm', 'ko');
      }
      return DateFormat('hh:mm aa', 'en');
    } catch (e) {
      debugPrint('DateFormat Locale error: $e');
      return DateFormat('hh:mm aa', 'en');
    }
  }

  DateFormat formatLocaleWeekDay() {
    try {
      final locale = LFLocalizations.shared.locale.toString();
      return DateFormat.E(locale);
    } catch (e) {
      debugPrint('DateFormat Locale error: $e');
      return DateFormat.E('en_US');
    }
  }

  // String formatTimestamp(
  //   int timestamp, {
  //   String format = 'yyyy.MM.dd HH:mm',
  // }) {
  //   if (timestamp == 0) return '0000.00.00 00:00';
  //   final dateTimeToLocal =
  //       DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  //   return DateFormat(format).format(dateTimeToLocal);
  // }
  //
  // bool betweenNow({required String startDate, required String endDate}) {
  //   if (isEmpty(startDate) || isEmpty(endDate)) return false;
  //   final n = DateTime.now().toLocal();
  //   final s = dateToTimeStampTZ(startDate);
  //   final e = dateToTimeStampTZ(endDate);
  //   final r1 = n.isAfter(s);
  //   final r2 = n.isBefore(e);
  //   return r1 && r2;
  // }
  //
  // int betweenDifferenceMinutes(
  //     {required int timestamp1, required int timestamp2}) {
  //   if (timestamp1 == 0 || timestamp2 == 0) return -1;
  //   final s = DateTime.fromMillisecondsSinceEpoch(timestamp1);
  //   final e = DateTime.fromMillisecondsSinceEpoch(timestamp2);
  //   final difference = e.difference(s).inMinutes;
  //   return difference;
  // }
}
