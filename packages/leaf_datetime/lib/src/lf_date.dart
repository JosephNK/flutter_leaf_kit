import 'package:jiffy/jiffy.dart';
import 'package:jiffy_klc/jiffy_klc.dart';

class LFDate {
  late Jiffy _jiffy;

  LFDate._internal(Jiffy jiffy) {
    _jiffy = jiffy;
  }

  Jiffy get jiffy => _jiffy;

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

  /// Manipulation
  LFDate add({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int weeks = 0,
    int months = 0,
    int years = 0,
  }) {
    _jiffy = _jiffy.add(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      weeks: weeks,
      months: months,
      years: years,
    );
    return this;
  }

  LFDate subtract({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int weeks = 0,
    int months = 0,
    int years = 0,
  }) {
    _jiffy = _jiffy.subtract(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      weeks: weeks,
      months: months,
      years: years,
    );
    return this;
  }

  /// Querying
  bool isBefore(LFDate other, {Unit unit = Unit.microsecond}) =>
      _jiffy.isBefore(other.jiffy, unit: unit);

  bool isAfter(LFDate other, {Unit unit = Unit.microsecond}) =>
      _jiffy.isAfter(other.jiffy, unit: unit);

  bool isSame(LFDate other, {Unit unit = Unit.microsecond}) =>
      _jiffy.isSame(other.jiffy, unit: unit);

  bool isSameOrAfter(LFDate other, {Unit unit = Unit.microsecond}) =>
      _jiffy.isSameOrAfter(other.jiffy, unit: unit);

  bool isSameOrBefore(LFDate other, {Unit unit = Unit.microsecond}) =>
      _jiffy.isSameOrBefore(other.jiffy, unit: unit);

  bool isBetween(
    LFDate otherFrom,
    LFDate otherTo, {
    Unit unit = Unit.microsecond,
  }) =>
      _jiffy.isBetween(otherFrom.jiffy, otherTo.jiffy, unit: unit);

  num diff(
    LFDate other, {
    Unit unit = Unit.microsecond,
    bool asFloat = false,
  }) =>
      _jiffy.diff(other.jiffy, unit: unit, asFloat: asFloat);
}
