part of lf_common;

abstract class LFLocalization {
  String get year;
  String get month;
  String get day;
  String get min;
  String get hour;
  String get ago;
  String get nowAgo;
  String get yesterday;
  String get shortLunar;
  String get shortSolar;

  List<String> get shortWeekdays;
  List<String> get shortMonths;
  List<String> get months;
}

class LFLocalizationEn extends LFLocalization {
  @override
  String get year => '';

  @override
  String get month => '';

  @override
  String get day => 'day';

  @override
  String get hour => 'hour';

  @override
  String get min => 'min';

  @override
  String get ago => 'ago';

  @override
  String get nowAgo => 'now';

  @override
  String get yesterday => 'yesterday';

  @override
  String get shortLunar => 'lunar';

  @override
  String get shortSolar => 'solar';

  @override
  List<String> get shortWeekdays => [
        'Sun',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
      ];

  @override
  List<String> get shortMonths => [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

  @override
  List<String> get months => [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
}

class LFLocalizationKo extends LFLocalization {
  @override
  String get year => '년';

  @override
  String get month => '월';

  @override
  String get day => '일';

  @override
  String get hour => '시';

  @override
  String get min => '분';

  @override
  String get ago => '전';

  @override
  String get nowAgo => '방금';

  @override
  String get yesterday => '어제';

  @override
  String get shortLunar => '음';

  @override
  String get shortSolar => '양';

  @override
  List<String> get shortWeekdays => [
        '일',
        '월',
        '화',
        '수',
        '목',
        '금',
        '토',
      ];

  @override
  List<String> get shortMonths => [
        '1월',
        '2월',
        '3월',
        '4월',
        '5월',
        '6월',
        '7월',
        '8월',
        '9월',
        '10월',
        '11월',
        '12월',
      ];

  @override
  List<String> get months => [
        '1월',
        '2월',
        '3월',
        '4월',
        '5월',
        '6월',
        '7월',
        '8월',
        '9월',
        '10월',
        '11월',
        '12월',
      ];
}

class LFLocalizations {
  static final LFLocalizations _instance = LFLocalizations._internal();

  static LFLocalizations get shared => _instance;

  LFLocalizations._internal();

  late LFLocalization _localization;
  late Locale _locale;
  late String _languageCode;

  LFLocalization get localization => LFLocalizations.shared._localization;

  Locale get locale => LFLocalizations.shared._locale;
  String get languageCode => LFLocalizations.shared._languageCode;

  void config(BuildContext context) {
    try {
      _locale = context.locale;
      _languageCode = _locale.languageCode;
      if (_languageCode == 'ko') {
        _localization = LFLocalizationKo();
      } else {
        _localization = LFLocalizationEn();
      }
    } catch (e) {
      debugPrint('DateFormat Locale error: $e');
      _localization = LFLocalizationEn();
    }
  }
}
