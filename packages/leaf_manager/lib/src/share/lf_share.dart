import 'package:flutter/material.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:share_plus/share_plus.dart';

class LFShareManager {
  static final LFShareManager _instance = LFShareManager._internal();
  static LFShareManager get shared => _instance;
  LFShareManager._internal();

  Future<ShareResultStatus> text(
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

  Future<ShareResultStatus> files(
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

  Future<ShareResultStatus> uri(
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
}
