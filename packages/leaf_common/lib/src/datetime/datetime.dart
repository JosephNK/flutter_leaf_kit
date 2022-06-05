import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

class LeafDateTime {
  LeafDateTime._();

  static String today({String format = 'yyyy-MM-dd HH:mm:ss'}) {
    final dateStr = DateFormat(format).format(DateTime.now());
    return dateStr;
  }

  static String foramtString(String value,
      {String format = 'yyyy.MM.dd HH:mm'}) {
    if (isEmpty(value)) return '0000.00.00 00:00';
    final dateTimeToLocal = dateToLocal(value);
    return DateFormat(format).format(dateTimeToLocal);
  }

  static String foramtDate(DateTime value,
      {String format = 'yyyy.MM.dd HH:mm'}) {
    return DateFormat(format).format(value);
  }

  static String foramtTimestamp(int timestamp,
      {String format = 'yyyy.MM.dd HH:mm'}) {
    if (timestamp == 0) return '0000.00.00 00:00';
    final dateTimeToLocal =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(dateTimeToLocal);
  }

  static DateTime dateToLocal(String value) {
    DateTime dateTime;

    final timeStamp = int.tryParse(value) ?? 0;
    if (timeStamp != 0) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    } else {
      try {
        dateTime = (value.contains('Z'))
            ? DateTime.parse(value)
            : DateTime.parse('${value}Z');
      } catch (e) {
        dateTime = DateTime.parse(value);
      }
    }

    return dateTime.toLocal();
  }

  static bool betweenNow({required String startDate, required String endDate}) {
    if (isEmpty(startDate) || isEmpty(endDate)) return false;
    final n = DateTime.now().toLocal();
    final s = dateToLocal(startDate);
    final e = dateToLocal(endDate);
    final r1 = n.isAfter(s);
    final r2 = n.isBefore(e);
    return r1 && r2;
  }

  static int betweenDifferenceMinutes(
      {required int timestamp1, required int timestamp2}) {
    if (timestamp1 == 0 || timestamp2 == 0) return -1;
    final s = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    final e = DateTime.fromMillisecondsSinceEpoch(timestamp2);
    final difference = e.difference(s).inMinutes;
    return difference;
  }
}
