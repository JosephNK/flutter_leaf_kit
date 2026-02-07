part of '../leaf_common.dart';

class LeafExtColor {
  static Color? hexToColor(String hex) {
    try {
      return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      return null;
    }
  }
}

extension ColorHelper on Color {
  Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}
