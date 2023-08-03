part of leaf_firebase;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  Logging.d('FirebaseManager Messaging Background message: $message');
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('[notificationTapBackground()]');
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // final initializationSettings = InitializationSettings(
  //   android: const AndroidInitializationSettings('mipmap/ic_launcher'),
  //   iOS: DarwinInitializationSettings(
  //     requestAlertPermission: false,
  //     requestBadgePermission: false,
  //     requestSoundPermission: false,
  //     onDidReceiveLocalNotification: (
  //       int id,
  //       String? title,
  //       String? body,
  //       String? payload,
  //     ) {
  //       debugPrint('[onDidReceiveLocalNotification()]');
  //     },
  //   ),
  // );
  //
  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: (final notificationResponse) async {
  //     debugPrint('[onDidReceiveNotificationResponse]');
  //     if (notificationResponse.payload != null) {
  //       debugPrint('notification payload: ${notificationResponse.payload}');
  //     }
  //   },
  //   onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  // );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
  isFlutterLocalNotificationsInitialized = true;
}

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   Map<String, dynamic> data = message.data;
//   dynamic sendbirdData = data['sendbird'];
//   if (sendbirdData != null) {
//     final sendbirdMap = json.decode(sendbirdData);
//     Random random = Random();
//     const int minInt32 = -2147483648;
//     const int maxInt32 = 2147483647;
//     int randomInt32 = random.nextInt(maxInt32 - minInt32 + 1) + minInt32;
//     final channelMap = sendbirdMap['channel'];
//     final channelName = channelMap['name'];
//     final channelUrl = channelMap['channel_url'];
//     final message = sendbirdMap['message'];
//     flutterLocalNotificationsPlugin.show(
//       randomInt32,
//       null,
//       message,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }

class FirebaseMessagingManager {
  static final FirebaseMessagingManager _instance =
      FirebaseMessagingManager._internal();

  static FirebaseMessagingManager get shared => _instance;

  FirebaseMessagingManager._internal() {
    Logging.d('FirebaseMessagingManager Init');
    setupFlutterNotifications();
  }

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<FirebaseApp> initialization() async {
    return Firebase.initializeApp();
  }

  Future<String?> registerTokenWithPermission(
      {bool usingPlatform = false}) async {
    final status = await _requestPermission();
    if (status != AuthorizationStatus.authorized) {
      return null;
    }
    if (usingPlatform) {
      if (Platform.isIOS) {
        return await _messaging.getAPNSToken();
      }
    }
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

  Future<void> listenBackgroundMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
