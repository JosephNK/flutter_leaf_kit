part of lf_common;

extension DateString on String {
  String toLongDateTime() {
    return LFDateTime.shared.formatString(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LFDateTime.shared.formatString(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LFDateTime.shared.formatString(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LFDateTime.shared.formatString(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LFDateTime.shared.formatString(this, format: 'MM.dd');
  }

  String toYear() {
    return LFDateTime.shared.formatString(this, format: 'yyyy');
  }

  String toMonth() {
    return LFDateTime.shared.formatString(this, format: 'MM');
  }

  String toDay() {
    return LFDateTime.shared.formatString(this, format: 'dd');
  }

  String toTime() {
    return LFDateTime.shared.formatString(this, format: 'HH:mm');
  }

  String toCurrency() {
    // TODO: Set Locale
    if (isEmpty(this)) return '0';
    return NumberFormat.currency(locale: 'ko', symbol: '')
        .format(int.parse(this));
  }

  String toAgo() {
    if (isEmpty(this)) return '';
    final dateTimeToLocal = LFDateTime.shared.dateToLocalTimeStampTZ(this);
    final now = DateTime.now();
    final difference = now.difference(dateTimeToLocal);
    if (difference.inHours < 1) {
      return '${difference.inMinutes}${LFDateTime.shared.localization.min} ${LFDateTime.shared.localization.ago}';
    } else if (difference.inHours < 23) {
      return '${difference.inHours}${LFDateTime.shared.localization.hour} ${LFDateTime.shared.localization.ago}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}${LFDateTime.shared.localization.day} ${LFDateTime.shared.localization.ago}';
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
