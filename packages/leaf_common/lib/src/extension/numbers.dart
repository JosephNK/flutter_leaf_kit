part of lf_common;

extension DateInt on int {
  DateTime toTimestamp() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  String toDate() {
    return toTimestamp().toShortDateTime();
  }

  String toTime() {
    return toTimestamp().toTime();
  }
}
