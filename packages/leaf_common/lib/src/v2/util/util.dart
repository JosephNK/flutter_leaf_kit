part of lf_common;

class LFUtil {
  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}
