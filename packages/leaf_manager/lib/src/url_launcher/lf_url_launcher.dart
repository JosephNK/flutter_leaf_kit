import 'package:url_launcher/url_launcher.dart' as ul;

// ReadME
// https://pub.dev/packages/url_launcher
class LFURLLauncherManager {
  static final LFURLLauncherManager _instance =
      LFURLLauncherManager._internal();
  static LFURLLauncherManager get shared => _instance;
  LFURLLauncherManager._internal();

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
}
