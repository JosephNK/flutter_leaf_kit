part of '../../leaf_manager.dart';

class LFTransparencyManager {
  static final LFTransparencyManager _instance =
      LFTransparencyManager._internal();

  static LFTransparencyManager get shared => _instance;

  LFTransparencyManager._internal();

  Future<void> requestAppTracking(BuildContext context) async {
    if (Platform.isIOS) {
      try {
        final TrackingStatus status =
            await AppTrackingTransparency.trackingAuthorizationStatus;
        if (status == TrackingStatus.notDetermined) {
          await Future.delayed(const Duration(milliseconds: 200));
          final TrackingStatus status =
              await AppTrackingTransparency.requestTrackingAuthorization();
          Logging.d('AppTrackingTransparency Status: $status');
        }
      } on PlatformException {
        Logging.d('AppTrackingTransparency PlatformException was thrown');
      }
    } else {
      Logging.i('AppTrackingTransparency not Supported');
    }
  }
}
