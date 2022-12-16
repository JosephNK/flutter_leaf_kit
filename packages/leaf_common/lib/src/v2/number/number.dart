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
}
