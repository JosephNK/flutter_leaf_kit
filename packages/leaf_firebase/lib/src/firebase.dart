part of leaf_firebase;

class FirebaseManager {
  static final FirebaseManager _instance = FirebaseManager._internal();

  static FirebaseManager get shared => _instance;

  FirebaseManager._internal() {
    Logging.d('FirebaseManager Init');
    _load();
  }

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<FirebaseApp> initialization() async {
    return Firebase.initializeApp();
  }

  Future<void> _load() async {
    /// flutter_local_notifications
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> registerTokenWithPermission() async {
    final status = await _requestPermission();
    if (status != AuthorizationStatus.authorized) {
      return null;
    }
    // if (Platform.isIOS) {
    //   return await _messaging.getAPNSToken();
    // }
    return await _messaging.getToken();
  }

  Future<void> listenInitialMessageApp(
      ValueChanged<RemoteMessage>? callBack) async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      callBack?.call(message);
    }
  }

  Future<void> listenMessageOpenedApp(
      ValueChanged<RemoteMessage>? callBack) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      callBack?.call(message);
    });
  }

  Future<void> listenForegroundMessaging(
      ValueChanged<RemoteMessage>? callBack) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      callBack?.call(message);
    });
  }

  Future<void> listenBackgroundMessaging(
      ValueChanged<RemoteMessage>? callBack) async {
    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      // If you're going to use other Firebase services in the background, such as Firestore,
      // make sure you call `initializeApp` before using other Firebase services.
      await Firebase.initializeApp();

      Logging.d('Handling a background message: ${message.messageId}');

      callBack?.call(message);
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<AuthorizationStatus> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus;
  }
}

class FirebaseData extends Equatable {
  final String? title;
  final String? body;
  final String? screen;
  final String? id;
  final String? platform;
  final String? type; // comment, reaction

  const FirebaseData({
    this.title,
    this.body,
    this.screen,
    this.id,
    this.platform,
    this.type,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        screen,
        id,
        platform,
        type,
      ];

  static FirebaseData create(RemoteMessage message) {
    var title = message.notification?.title;
    var body = message.notification?.body;
    var screen = message.data['screen'] as String;
    var id = message.data['id'] as String;
    var platform = message.data['platform'] as String;
    var type = message.data['type'] as String;

    return FirebaseData(
      title: title,
      body: body,
      screen: screen,
      id: id,
      platform: platform,
      type: type,
    );
  }
}
