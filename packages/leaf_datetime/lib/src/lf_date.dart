import 'package:jiffy/jiffy.dart';
import 'package:jiffy_klc/jiffy_klc.dart';

class LFDate {
  late Jiffy _jiffy;

  LFDate._internal(Jiffy jiffy) {
    _jiffy = jiffy;
  }

  // Jiffy get jiffy => _jiffy;

  DateTime get dateTime => _jiffy.dateTime;

  /// Returns the microsecond ranging from 0 to 999.
  int get microsecond => _jiffy.microsecond;

  /// Returns the number of microseconds since epoch time
  /// `January 1, 1970, 00:00:00 UTC`.
  int get microsecondsSinceEpoch => _jiffy.microsecondsSinceEpoch;

  /// Returns the millisecond ranging from 0 to 999.
  int get millisecond => _jiffy.millisecond;

  /// Returns the number of milliseconds since epoch time
  /// `January 1, 1970, 00:00:00 UTC`.
  int get millisecondsSinceEpoch => _jiffy.millisecondsSinceEpoch;

  /// Returns the second ranging from 0 to 59.
  int get second => _jiffy.second;

  /// Returns the minute ranging from 0 to 59.
  int get minute => _jiffy.minute;

  /// Returns the hour ranging from 0 to 23.
  int get hour => _jiffy.hour;

  /// Returns the date ranging from 1 to 31.
  int get date => _jiffy.date;

  factory LFDate.now() {
    final object = Jiffy.now();
    return LFDate._internal(object);
  }

  factory LFDate.parseFromString(String string, {bool isUtc = false}) {
    final object = Jiffy.parse(string, isUtc: isUtc);
    return LFDate._internal(object);
  }

  factory LFDate.parseFromMicrosecondsSinceEpoch(
    int microsecondsSinceEpoch, {
    bool isUtc = false,
  }) {
    final object = Jiffy.parseFromMicrosecondsSinceEpoch(
      microsecondsSinceEpoch,
      isUtc: isUtc,
    );
    return LFDate._internal(object);
  }

  factory LFDate.parseFromList(List<int> list, {bool isUtc = false}) {
    final object = Jiffy.parseFromList(list, isUtc: isUtc);
    return LFDate._internal(object);
  }

  factory LFDate.parseFromDateTime(DateTime dateTime) {
    final object = Jiffy.parseFromDateTime(dateTime);
    return LFDate._internal(object);
  }

  factory LFDate.parseFromJiffy(Jiffy jiffy) {
    final object = Jiffy.parseFromJiffy(jiffy);
    return LFDate._internal(object);
  }

  DateTime toLocal() {
    return _jiffy.toLocal().dateTime;
  }

  DateTime toUtc() {
    return _jiffy.toUtc().dateTime;
  }

  String format(String format) {
    return _jiffy.format(pattern: format);
  }

  Jiffy toLunar() {
    return _jiffy.toLunar();
  }

  Jiffy toSolarFromLunar() {
    return _jiffy.toSolarFromLunar();
  }

  String toLunarFormat(String format) {
    return toLunar().format(pattern: format);
  }

  String toSolarFromLunarFormat(String format) {
    return toSolarFromLunar().format(pattern: format);
  }
}
