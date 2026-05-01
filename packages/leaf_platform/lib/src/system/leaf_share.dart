import 'package:flutter/material.dart';
import 'package:flutter_leaf_core/leaf_core.dart';
import 'package:share_plus/share_plus.dart';

class LeafShare {
  static Future<ShareResultStatus> text(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
      return result.status;
    } catch (e) {
      LeafLogging.e('Share.share Error: $e');
    }
    return ShareResultStatus.unavailable;
  }

  static Future<ShareResultStatus> files(
    List<XFile> files, {
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
          files: files,
        ),
      );
      return result.status;
    } catch (e) {
      LeafLogging.e('Share.shareXFiles Error: $e');
    }
    return ShareResultStatus.unavailable;
  }

  static Future<ShareResultStatus> uri(
    Uri uri, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(uri: uri, sharePositionOrigin: sharePositionOrigin),
      );
      return result.status;
    } catch (e) {
      LeafLogging.e('Share.shareUri Error: $e');
    }
    return ShareResultStatus.unavailable;
  }
}
