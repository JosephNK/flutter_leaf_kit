import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class LauncherManager {
  static final LauncherManager _instance = LauncherManager._internal();

  static LauncherManager get shared => _instance;

  LauncherManager._internal();

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
