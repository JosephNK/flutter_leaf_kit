import '../lf_date.dart';

extension LFDateDateTime on DateTime {
  bool isToday() {
    final today = LFDate.now().dateTime;
    return isSameDateTime(today, onlyDate: true);
  }

  bool isSameDateTime(DateTime other, {bool onlyDate = false}) {
    if (onlyDate) {
      return year == other.year && month == other.month && day == other.day;
    }
    return compareTo(other) == 0;
  }
}
