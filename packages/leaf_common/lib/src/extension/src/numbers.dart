part of leaf_extension;

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
