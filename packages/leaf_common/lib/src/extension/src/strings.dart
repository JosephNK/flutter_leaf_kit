part of leaf_extension;

extension DateString on String {
  String toLongDateTime() {
    return LeafDateTime.foramtString(this, format: 'yyyy.MM.dd HH:mm');
  }

  String toShortDateTime() {
    return LeafDateTime.foramtString(this, format: 'yyyy.MM.dd');
  }

  String toCalendarLongDateTime() {
    return LeafDateTime.foramtString(this, format: 'yyyy-MM-dd HH:mm');
  }

  String toCalendarShortDateTime() {
    return LeafDateTime.foramtString(this, format: 'yyyy-MM-dd');
  }

  String toDate() {
    return LeafDateTime.foramtString(this, format: 'MM.dd');
  }

  String toYear() {
    return LeafDateTime.foramtString(this, format: 'yyyy');
  }

  String toMonth() {
    return LeafDateTime.foramtString(this, format: 'MM');
  }

  String toDay() {
    return LeafDateTime.foramtString(this, format: 'dd');
  }

  String toTime() {
    return LeafDateTime.foramtString(this, format: 'HH:mm');
  }

  String toCurrency() {
    if (isEmpty(this)) return '0';
    return NumberFormat.currency(locale: 'ko', symbol: '')
        .format(int.parse(this));
  }

  String toAgo() {
    if (isEmpty(this)) return '';
    final dateTimeToLocal = LeafDateTime.dateToLocal(this);
    final now = DateTime.now();
    final difference = now.difference(dateTimeToLocal);
    if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 23) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
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
