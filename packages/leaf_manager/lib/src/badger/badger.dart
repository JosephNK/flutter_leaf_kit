import 'package:flutter_app_badger/flutter_app_badger.dart';

class LeafAppBadger {
  static Future<bool> isAppBadgeSupported() async {
    return await FlutterAppBadger.isAppBadgeSupported();
  }

  static Future<void> removeBadge() async {
    final isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    if (isAppBadgeSupported) {
      FlutterAppBadger.removeBadge();
    }
  }
}
