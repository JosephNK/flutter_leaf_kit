import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class LFAppManager {
  LFAppManager();
  // int get imageQuality => 100;
  // int get imageSaveAlbumQuality => 100;
  // // ExpireDate 체크 함수
  // String? get expiredDate => null;
  // bool isExpire() {
  //   if (isEmpty(expiredDate)) {
  //     return false;
  //   }
  //   final now = DateTime.now();
  //   return now.isAfter(DateTime.parse(expiredDate!));
  // }

  /// URLLaunch
  /// https://pub.dev/packages/url_launcher
  Future<bool> launchUrl(
    Uri url, {
    ul.LaunchMode mode = ul.LaunchMode.platformDefault,
    ul.WebViewConfiguration webViewConfiguration =
        const ul.WebViewConfiguration(),
    String? webOnlyWindowName,
    bool checkCanUrl = true,
  }) async {
    if (checkCanUrl) {
      final resultCan = await ul.canLaunchUrl(url);
      if (resultCan) {
        return false;
      }
    }
    final result = await ul.launchUrl(
      url,
      mode: mode,
      webViewConfiguration: webViewConfiguration,
      webOnlyWindowName: webOnlyWindowName,
    );
    return result;
  }

  /// Share
  Future<ShareResultStatus> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
      return result.status;
    } catch (e) {
      Logging.e('Share.share Error: $e');
    }
    return ShareResultStatus.unavailable;
  }

  Future<ShareResultStatus> shareFiles(
    List<XFile> files, {
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await Share.shareXFiles(
        files,
        subject: subject,
        text: text,
        sharePositionOrigin: sharePositionOrigin,
      );
      return result.status;
    } catch (e) {
      Logging.e('Share.shareXFiles Error: $e');
    }
    return ShareResultStatus.unavailable;
  }

  Future<ShareResultStatus> shareUri(
    Uri uri, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await Share.shareUri(
        uri,
        sharePositionOrigin: sharePositionOrigin,
      );
      return result.status;
    } catch (e) {
      Logging.e('Share.shareUri Error: $e');
    }
    return ShareResultStatus.unavailable;
  }

  /// AppTrackingTransparency
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

  /// AppBadge
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
