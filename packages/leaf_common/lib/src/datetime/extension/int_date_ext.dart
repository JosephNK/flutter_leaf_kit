part of lf_common;

extension DateIntString on int {
  String toAgo() {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return LFLocalizations.shared.localization.nowAgo;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}${LFLocalizations.shared.localization.min} ${LFLocalizations.shared.localization.ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}${LFLocalizations.shared.localization.hour} ${LFLocalizations.shared.localization.ago}';
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return LFLocalizations.shared.localization.yesterday;
    } else {
      try {
        final languageCode = LFLocalizations.shared.languageCode;
        if (languageCode == 'ko') {
          final format = DateFormat.MMMd('ko_KR');
          return format.format(dateTime);
        }
        final format = DateFormat.MMMd('en_US');
        return format.format(dateTime);
      } catch (e) {
        debugPrint('DateFormat Locale error: $e');
        final format = DateFormat.MMMd('en_US');
        return format.format(dateTime);
      }
    }
  }
}
