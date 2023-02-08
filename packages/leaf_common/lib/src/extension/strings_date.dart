part of lf_common;

extension DateString on String {
  String toLongDateTime() {
    return LFDateTime.formatString(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LFDateTime.formatString(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LFDateTime.formatString(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LFDateTime.formatString(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LFDateTime.formatString(this, format: 'MM.dd');
  }

  String toYear() {
    return LFDateTime.formatString(this, format: 'yyyy');
  }

  String toMonth() {
    return LFDateTime.formatString(this, format: 'MM');
  }

  String toDay() {
    return LFDateTime.formatString(this, format: 'dd');
  }

  String toTime() {
    return LFDateTime.formatString(this, format: 'HH:mm');
  }

  String toCurrency() {
    if (isEmpty(this)) return '0';
    return NumberFormat.currency(locale: 'ko', symbol: '')
        .format(int.parse(this));
  }

  String toAgo() {
    if (isEmpty(this)) return '';
    final dateTimeToLocal = LFDateTime.dateToLocal(this);
    final now = DateTime.now();
    final difference = now.difference(dateTimeToLocal);
    if (difference.inHours < 1) {
      return '${difference.inMinutes}${LFDateTime.localization.min} ${LFDateTime.localization.ago}';
    } else if (difference.inHours < 23) {
      return '${difference.inHours}${LFDateTime.localization.hour} ${LFDateTime.localization.ago}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}${LFDateTime.localization.day} ${LFDateTime.localization.ago}';
    }
    return toLongDateTime();
  }

  String? toTimestamp() {
    if (isEmpty(this)) return null;
    return (DateTime.parse(this).millisecondsSinceEpoch ~/ 1000).toString();
  }

  bool isBeforeNow() {
    if (isEmpty(this)) return false;
    return DateTime.parse(this).isBefore(DateTime.now());
  }
}
