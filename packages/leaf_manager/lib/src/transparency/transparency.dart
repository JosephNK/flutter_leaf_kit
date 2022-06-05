import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaf_common/leaf_common.dart';

class LeafTransparency {
  static Future<void> requestAppTracking(BuildContext context) async {
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
