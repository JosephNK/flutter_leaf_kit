import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class LeafLauncher {
  static Future<void> openLink(String link) async {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(link);
    }
  }

  static Future<void> openBrowser(String link) async {
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
