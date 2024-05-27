import 'lf_localization.dart';

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
  String get hourOther => 'hour';

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
