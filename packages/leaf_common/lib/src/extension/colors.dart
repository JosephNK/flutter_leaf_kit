part of '../lf_common.dart';

extension ColorHelper on Color {
  Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}
