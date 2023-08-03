part of leaf_firebase;

class FirebaseAnalyticsManager {
  static final FirebaseAnalyticsManager _instance =
      FirebaseAnalyticsManager._internal();

  static FirebaseAnalyticsManager get shared => _instance;

  FirebaseAnalyticsManager._internal() {
    Logging.d('FirebaseAnalyticsManager Init');
    setupFlutterNotifications();
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // static Future<FirebaseApp> initialization() async {
  //   return Firebase.initializeApp();
  // }

  Future<void> setUserId(String? id) async {
    await analytics.setUserId(id: id);
  }

  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }
}
