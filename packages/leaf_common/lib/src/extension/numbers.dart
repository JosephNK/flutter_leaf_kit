part of '../lf_common.dart';

extension NumberInt on int {
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

  // locale: 'ko_KR'
  String currency({
    String? locale,
    String? name,
    String? symbol,
    int? decimalDigits,
    String? customPattern,
  }) {
    final f = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    return f.format(this);
  }
}
