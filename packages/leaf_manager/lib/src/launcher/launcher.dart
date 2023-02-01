import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class LFLauncherManager {
  static final LFLauncherManager _instance = LFLauncherManager._internal();

  static LFLauncherManager get shared => _instance;

  LFLauncherManager._internal();

  Future<void> openLink(String link) async {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(link);
    }
  }

  Future<void> openBrowser(String link) async {
    if (await canLaunchUrlString(link)) {
      if (Platform.isAndroid) {
        await launchUrlString(link, mode: LaunchMode.platformDefault);
      }
      if (Platform.isIOS) {
        await launchUrlString(link, mode: LaunchMode.platformDefault);
      }
    }
  }
}
