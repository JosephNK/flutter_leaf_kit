part of leaf_extension;

extension DateTimeString on DateTime {
  String toLongDateTime() {
    return LeafDateTime.foramtDate(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LeafDateTime.foramtDate(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LeafDateTime.foramtDate(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LeafDateTime.foramtDate(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LeafDateTime.foramtDate(this, format: 'MM.dd');
  }

  String toYear() {
    return LeafDateTime.foramtDate(this, format: 'yyyy');
  }

  String toMonth() {
    return LeafDateTime.foramtDate(this, format: 'MM');
  }

  String toDay() {
    return LeafDateTime.foramtDate(this, format: 'dd');
  }

  String toTime() {
    return LeafDateTime.foramtDate(this, format: 'HH:mm');
  }
}

extension DateTimeInt on DateTime {
  int diffMinutes(DateTime dateTime) {
    return difference(dateTime).inMinutes;
  }

  int diffSeconds(DateTime dateTime) {
    return difference(dateTime).inSeconds;
  }
}
