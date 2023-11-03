part of lf_common;

class LFAppBadgerManager {
  static final LFAppBadgerManager _instance = LFAppBadgerManager._internal();

  static LFAppBadgerManager get shared => _instance;

  LFAppBadgerManager._internal();

  Future<bool> isAppBadgeSupported() async {
    return await FlutterAppBadger.isAppBadgeSupported();
  }

  Future<void> updateBadgeCount(int count) async {
    final isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    if (isAppBadgeSupported) {
      FlutterAppBadger.updateBadgeCount(count);
    }
  }

  Future<void> removeBadge() async {
    final isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    if (isAppBadgeSupported) {
      FlutterAppBadger.removeBadge();
    }
  }
}
