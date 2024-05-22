import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

class LFTransparencyManager {
  static final LFTransparencyManager _instance =
      LFTransparencyManager._internal();
  static LFTransparencyManager get shared => _instance;
  LFTransparencyManager._internal();

  Future<TrackingStatus> requestAppTracking(BuildContext context) async {
    try {
      if (Platform.isIOS) {
        try {
          final TrackingStatus status =
              await AppTrackingTransparency.trackingAuthorizationStatus;
          if (status == TrackingStatus.notDetermined) {
            await Future.delayed(const Duration(milliseconds: 200));
            final TrackingStatus status =
                await AppTrackingTransparency.requestTrackingAuthorization();
            Logging.d('AppTrackingTransparency Status: $status');
            return status;
          }
        } on PlatformException {
          Logging.d('AppTrackingTransparency PlatformException was thrown');
          rethrow;
        }
      }
      return TrackingStatus.notSupported;
    } catch (e) {
      rethrow;
    }
  }
}
