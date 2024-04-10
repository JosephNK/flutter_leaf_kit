part of '../lf_common.dart';

class CupertinoLocalizationsKoFixedDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalizationsKoFixedDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'ko' && locale.countryCode == 'KR';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      CupertinoLocalizationsKoFixed.load(locale);

  @override
  bool shouldReload(CupertinoLocalizationsKoFixedDelegate old) => false;
}

class CupertinoLocalizationsKoFixed implements CupertinoLocalizations {
  /// Constructs an object that defines the cupertino widgets' localized strings
  /// for US English (only).
  ///
  /// [LocalizationsDelegate] implementations typically call the static [load]
  /// function, rather than constructing this class directly.
  CupertinoLocalizationsKoFixed() {
    _shortWeekdays = LFLocalizationKo().shortWeekdays;
    _shortMonths = LFLocalizationKo().shortMonths;
    _months = LFLocalizationKo().months;
  }

  late List<String> _shortWeekdays;
  late List<String> _shortMonths;
  late List<String> _months;

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) {
    if (weekDay != null) {
      return ' ${_shortWeekdays[weekDay - DateTime.monday]} $dayIndex ';
    }

    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) => hour.toString().padLeft(2, '0');

  @override
  String datePickerHourSemanticsLabel(int hour) => "$hour o'clock";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1) {
      return '1 minute';
    }
    return '$minute minutes';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.ymd;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_dayPeriod_time;

  @override
  String get anteMeridiemAbbreviation => '오전';

  @override
  String get postMeridiemAbbreviation => '오후';

  @override
  String get todayLabel => '오늘';

  @override
  String get alertDialogLabel => '알림';

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? 'hour' : 'hours';

  @override
  List<String> get timerPickerHourLabels => const <String>['hour', 'hours'];

  @override
  String timerPickerMinuteLabel(int minute) => 'min.';

  @override
  List<String> get timerPickerMinuteLabels => const <String>['min.'];

  @override
  String timerPickerSecondLabel(int second) => 'sec.';

  @override
  List<String> get timerPickerSecondLabels => const <String>['sec.'];

  @override
  String get cutButtonLabel => '잘라냄';

  @override
  String get copyButtonLabel => '복사';

  @override
  String get pasteButtonLabel => '붙여넣기';

  @override
  String get selectAllButtonLabel => '전체 선택';

  @override
  String get searchTextFieldPlaceholderLabel => '검색';

  @override
  String get modalBarrierDismissLabel => '닫기';

  @override
  String get noSpellCheckReplacementsLabel => '교체품 없음';

  @override
  // TODO: implement clearButtonLabel
  String get clearButtonLabel => throw UnimplementedError();

  @override
  String datePickerStandaloneMonth(int monthIndex) {
    // TODO: implement datePickerStandaloneMonth
    throw UnimplementedError();
  }

  @override
  // TODO: implement lookUpButtonLabel
  String get lookUpButtonLabel => throw UnimplementedError();

  @override
  // TODO: implement menuDismissLabel
  String get menuDismissLabel => throw UnimplementedError();

  @override
  // TODO: implement searchWebButtonLabel
  String get searchWebButtonLabel => throw UnimplementedError();

  @override
  // TODO: implement shareButtonLabel
  String get shareButtonLabel => throw UnimplementedError();

  /// Creates an object that provides US English resource values for the
  /// cupertino library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  static Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture(CupertinoLocalizationsKoFixed());

  /// A [LocalizationsDelegate] that uses [CupertinoLocalizationsKoFixed.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      CupertinoLocalizationsKoFixedDelegate();
}
