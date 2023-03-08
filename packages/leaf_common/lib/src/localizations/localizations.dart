part of lf_common;

abstract class LFLocalizations {
  String get year;
  String get month;
  String get day;
  String get min;
  String get hour;
  String get ago;

  List<String> get shortWeekdays;
  List<String> get shortMonths;
  List<String> get months;
}

class LFLocalizationsEn extends LFLocalizations {
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
  List<String> get shortWeekdays => [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
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

class LFLocalizationsKo extends LFLocalizations {
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
  List<String> get shortWeekdays => [
        '월',
        '화',
        '수',
        '목',
        '금',
        '토',
        '일',
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
