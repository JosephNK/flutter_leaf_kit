part of lf_common;

extension DateString on String {
  String toLongDateTime({String format = 'yyyy.MM.dd HH:mm'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toShortDateTime({String format = 'yyyy.MM.dd'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toDate({String format = 'MM.dd'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toYear({String format = 'yyyy'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toMonth({String format = 'MM'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toDay({String format = 'dd'}) {
    return LFDateTime.shared.formatString(this, format: format);
  }

  String toTime({String format = 'HH:mm'}) {
    return LFDateTime.shared.formatString(this, format: format);
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
