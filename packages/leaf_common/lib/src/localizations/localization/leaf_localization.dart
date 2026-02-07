export 'leaf_localization_en.dart';
export 'leaf_localization_ko.dart';

abstract class LeafLocalization {
  String get year;
  String get month;
  String get day;
  String get min;
  String get hour;
  String get hourOther;
  String get ago;
  String get nowAgo;
  String get yesterday;
  String get shortLunar;
  String get shortSolar;

  List<String> get shortWeekdays;
  List<String> get shortMonths;
  List<String> get months;
}
