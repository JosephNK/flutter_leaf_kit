part of lf_common;

extension DateTimeString on DateTime {
  String toLongDateTime() {
    return LFDateTime.formatDate(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LFDateTime.formatDate(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LFDateTime.formatDate(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LFDateTime.formatDate(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LFDateTime.formatDate(this, format: 'MM.dd');
  }

  String toYear() {
    return LFDateTime.formatDate(this, format: 'yyyy');
  }

  String toMonth() {
    return LFDateTime.formatDate(this, format: 'MM');
  }

  String toDay() {
    return LFDateTime.formatDate(this, format: 'dd');
  }

  String toTime() {
    return LFDateTime.formatDate(this, format: 'HH:mm');
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
