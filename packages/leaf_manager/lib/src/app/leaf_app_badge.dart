import 'package:app_badge_plus/app_badge_plus.dart';

class LeafAppBadge {
  static Future<bool> isSupported() async {
    return await AppBadgePlus.isSupported();
  }

  static Future<void> updateCount(int count) async {
    final isSupported = await AppBadgePlus.isSupported();
    if (isSupported) {
      AppBadgePlus.updateBadge(count);
    }
  }

  static Future<void> remove() async {
    final isSupported = await AppBadgePlus.isSupported();
    if (isSupported) {
      AppBadgePlus.updateBadge(0);
    }
  }
}
