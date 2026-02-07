part of 'leaf_webview.dart';

typedef LeafWebViewOnJavaScriptMessageReceived = Function(
    JavaScriptMessage javaScriptMessage);
typedef LeafWebViewOnRegisterJavaScriptChannel = Function(
    WebViewController webViewController);

class LeafWebViewController {
  LeafWebViewController() {
    _messageStreamController =
        StreamController<Map<String, JavaScriptMessage>>();
    _messageStreamController?.stream.listen((data) {
      for (final key in data.keys) {
        final message = data[key];
        if (onMessageReceived.keys.contains(key) && message != null) {
          final func = onMessageReceived[key];
          func?.call(message);
        }
      }
    });
  }

  void dispose() {
    _messageStreamController?.close();
    onMessageReceived.clear();
  }

  static Future<void> clearCookies() async {
    // WebViewCookieManager clears cookies for webview
    final WebViewCookieManager webViewCookieManager = WebViewCookieManager();
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      final WebKitWebViewCookieManager webKitManager =
          webViewCookieManager.platform as WebKitWebViewCookieManager;
      await webKitManager.clearCookies();
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      final AndroidWebViewCookieManager androidManager =
          webViewCookieManager.platform as AndroidWebViewCookieManager;
      await androidManager.clearCookies();
    }
    Logging.d('All WebViewCookieManager have been cleared.');

    // CookieManager clears cookies
    CookieManager cookieManager = CookieManager.instance();
    await cookieManager.deleteAllCookies();
    Logging.d('All CookieManager have been cleared.');
  }

  static Future<void> deleteAllData() async {
    // WebStorageManager clears web storage data
    if (Platform.isAndroid) {
      await WebStorageManager.instance().deleteAllData();
    } else if (Platform.isIOS) {
      await WebStorageManager.instance().removeDataModifiedSince(
        dataTypes: WebsiteDataType.ALL,
        date: DateTime.fromMillisecondsSinceEpoch(0),
      );
    }
    Logging.d('All Web Storage Data have been cleared.');
  }

  late WebViewController webViewController;
  StreamController<Map<String, JavaScriptMessage>>? _messageStreamController;
  List<String> javaScriptChannelNames = [];
  Map<String, LeafWebViewOnJavaScriptMessageReceived> onMessageReceived = {};
  List<LeafWebViewOnRegisterJavaScriptChannel> onRegisterJavaScriptChannels = [];

  /// Load the webview with the given [uri].
  Future<void> loadRequest(
    Uri uri, {
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
  }) async {
    return webViewController.loadRequest(
      uri,
      method: method,
      headers: headers,
      body: body,
    );
  }

  /// Load the webview with the given [html] string.
  Future<void> loadHtmlString(
    String html, {
    String? baseUrl,
  }) async {
    return webViewController.loadHtmlString(html, baseUrl: baseUrl);
  }

  /// Load the webview with the given [absoluteFilePath].
  Future<void> loadFile(String absoluteFilePath) async {
    return webViewController.loadFile(absoluteFilePath);
  }

  /// Load the webview with the given [key].
  Future<void> loadFlutterAsset(String key) async {
    return webViewController.loadFlutterAsset(key);
  }

  void addJavaScriptMessageStream(Map<String, JavaScriptMessage> data) {
    _messageStreamController?.sink.add(data);
  }

  void addJavaScriptChannelName(
    String name, {
    required void Function(JavaScriptMessage) onMessageReceived,
  }) {
    javaScriptChannelNames.add(name);
    this.onMessageReceived[name] = onMessageReceived;
  }

  void addJavaScriptChannelFunc(LeafWebViewOnRegisterJavaScriptChannel func) {
    onRegisterJavaScriptChannels.add(func);
  }

  Future<Object> runJavaScriptReturningResult(String javaScript) {
    return webViewController.runJavaScriptReturningResult(javaScript);
  }

  Future<String?> getUserAgent() async {
    return await webViewController.getUserAgent();
  }

  Future<void> setUserAgent(String userAgent) async {
    await webViewController.setUserAgent(userAgent);
  }

  Future<void> clearCache() async {
    await webViewController.clearCache();
  }

  Future<void> clearLocalStorage() async {
    await webViewController.clearLocalStorage();
  }

  Future<bool> canGoBack() async {
    return await webViewController.canGoBack();
  }

  Future<bool> canGoForward() async {
    return await webViewController.canGoForward();
  }

  Future<void> goBack() async {
    await webViewController.goBack();
  }

  Future<void> goForward() async {
    await webViewController.goForward();
  }

  Future<void> reload() async {
    await webViewController.reload();
  }
}
