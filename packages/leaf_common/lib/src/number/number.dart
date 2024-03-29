part of lf_common;

class LFNumber {
  static String currency(num value,
      {String locale = 'ko_KR', String symbol = ''}) {
    final f = NumberFormat.currency(locale: locale, symbol: symbol);
    return f.format(value);
  }
}

extension LFNumberInt on int {
  String currency({String locale = 'ko_KR', String symbol = ''}) {
    return LFNumber.currency(this, locale: locale, symbol: symbol);
  }

  String formatSize() {
    double len = toDouble();
    List<String> units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB'];
    int i = 0;
    while (len >= 1024 && i < units.length - 1) {
      len /= 1024;
      i++;
    }
    return '${len.toStringAsFixed(2)} ${units[i]}';
  }
}
