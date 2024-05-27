import 'lf_localization.dart';

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
  String get hourOther => '시간';

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
