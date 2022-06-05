import 'lib/dart_notification_center.dart';

export 'lib/dart_notification_center.dart';

class LeafNotificationCenterName {}

class LeafNotificationCenter {
  /// subscribe
  static void subscribe({
    required String channel,
    required dynamic observer,
    required ObserverCallback onNotification,
  }) {
    DartNotificationCenter.subscribe(
      channel: channel,
      observer: observer,
      onNotification: onNotification,
    );
  }

  /// unsubscribe
  static void unsubscribe({
    required String channel,
    required dynamic observer,
  }) {
    DartNotificationCenter.unsubscribe(
      channel: channel,
      observer: observer,
    );
  }

  /// post
  static void post({
    required String channel,
    required dynamic options,
  }) {
    DartNotificationCenter.post(
      channel: channel,
      options: options,
    );
  }
}
