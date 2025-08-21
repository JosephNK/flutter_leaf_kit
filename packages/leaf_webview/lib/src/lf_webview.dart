part of '../leaf_webview.dart';

enum LFWebViewEventType {
  mailto,
  tel,
  geo,
}

typedef LFWebViewOnBeforeLoaded = Function();
typedef LFWebViewOnLoaded = Function();
typedef LFWebViewOnLoaderBuilder = Widget Function();
typedef LFWebViewOnCreateWebViewController = Function(
    WebViewController webViewController);
typedef LFWebViewOnPageStarted = Function();
typedef LFWebViewOnPageFinished = Function();
typedef LFWebViewOnHeightFinished = Function(double height);
typedef LFWebViewOnNavigationDecision = bool Function(
    LFWebViewEventType? type, String url);

class LFWebView extends StatefulWidget {
  final LFWebViewController controller;
  final Uri? uri;
  final String? htmlString;
  final String? htmlFile;
  final String? assetFile;
  final bool fullScreen;
  final double initHeight;
  final Color backgroundColor;
  final bool allowAllowOrientation;
  final bool useHybridComposition;
  final String? userAgent;
  final LFWebViewOnBeforeLoaded? onInitBeforeLoaded;
  final LFWebViewOnLoaded? onInitLoaded;
  final LFWebViewOnCreateWebViewController? onCreateWebViewController;
  final LFWebViewOnPageStarted? onPageStarted;
  final LFWebViewOnPageFinished? onPageFinished;
  final LFWebViewOnLoaderBuilder? onLoaderBuilder;
  final LFWebViewOnHeightFinished? onHeightFinished;
  final LFWebViewOnNavigationDecision? onNavigationDecision;

  const LFWebView({
    super.key,
    required this.controller,
    this.uri,
    this.htmlString,
    this.htmlFile,
    this.assetFile,
    this.fullScreen = true,
    this.initHeight = 0.0,
    this.backgroundColor = const Color(0x00000000),
    this.allowAllowOrientation = false,
    this.useHybridComposition = false,
    this.userAgent,
    this.onInitBeforeLoaded,
    this.onInitLoaded,
    this.onLoaderBuilder,
    this.onCreateWebViewController,
    this.onPageStarted,
    this.onPageFinished,
    this.onHeightFinished,
    this.onNavigationDecision,
  });

  @override
  State<LFWebView> createState() => _LFWebViewState();
}

class _LFWebViewState extends State<LFWebView> {
  late NavigationDelegate _navigationDelegate;

  double _contentHeight = 0.0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final initHeight = widget.initHeight;
    final backgroundColor = widget.backgroundColor;
    final allowAllowOrientation = widget.allowAllowOrientation;
    final userAgent = widget.userAgent;
    final uri = widget.uri;
    final htmlString = widget.htmlString;
    final htmlFile = widget.htmlFile;
    final assetFile = widget.assetFile;
    final onInitBeforeLoaded = widget.onInitBeforeLoaded;
    final onInitLoaded = widget.onInitLoaded;
    final onCreateWebViewController = widget.onCreateWebViewController;
    final onPageStarted = widget.onPageStarted;
    final onPageFinished = widget.onPageFinished;

    _contentHeight = initHeight;

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController webViewController =
        WebViewController.fromPlatformCreationParams(params);

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      AndroidWebViewController androidWebViewController =
          (webViewController.platform as AndroidWebViewController);
      androidWebViewController.setMediaPlaybackRequiresUserGesture(false);

      // SetCustomWidgetCallbacks
      androidWebViewController.setCustomWidgetCallbacks(
        onShowCustomWidget:
            (Widget child, OnHideCustomWidgetCallback callback) {
          if (allowAllowOrientation) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
            ]);
          }
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => child,
              fullscreenDialog: true,
            ),
          );
        },
        onHideCustomWidget: () {
          if (allowAllowOrientation) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }
          Navigator.of(context).pop();
        },
      );
    }

    _navigationDelegate = NavigationDelegate(
      onProgress: (int progress) {
        Logging.d('[LFWebView] onProgress = ${progress.toString()}');
      },
      onPageStarted: (String url) {
        Logging.d('[LFWebView] onPageStarted = $url');
        onPageStarted?.call();
      },
      onPageFinished: (String url) async {
        Logging.d('[LFWebView] onPageFinished = $url');
        await updateWebViewHeightAfterOnPageFinished();
        onPageFinished?.call();
      },
      onWebResourceError: (WebResourceError error) {
        Logging.d('[LFWebView] onWebResourceError = ${error.errorCode}');
      },
      onNavigationRequest: (NavigationRequest request) async {
        Logging.d('[LFWebView] navigationDelegate = ${request.url}');
        return await navigationURLToLinkEvent(request.url);
      },
      onHttpAuthRequest: (HttpAuthRequest request) async {
        Logging.d('[LFWebView] onHttpAuthRequest = ${request.realm}');
      },
      onUrlChange: (UrlChange change) {
        Logging.d('[LFWebView] onUrlChange = ${change.url}');
      },
      onHttpError: (HttpResponseError error) {
        Logging.d('[LFWebView] onHttpError = ${error.response}');
      },
    );

    webViewController
      // ..loadRequest(Uri.parse('about:blank'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(backgroundColor)
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(_navigationDelegate);

    // Set WebViewController
    controller.webViewController = webViewController;

    // OnCreateWebViewController
    onCreateWebViewController?.call(webViewController);

    // Register Channel for Names
    for (var javaScriptChannelName in controller.javaScriptChannelNames) {
      controller.webViewController.addJavaScriptChannel(
        javaScriptChannelName,
        onMessageReceived: (message) {
          controller
              .addJavaScriptMessageStream({javaScriptChannelName: message});
        },
      );
    }

    // Register Channels for Functions
    for (var onRegisterJavaScriptChannel
        in controller.onRegisterJavaScriptChannels) {
      onRegisterJavaScriptChannel.call(webViewController);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await onInitBeforeLoaded?.call();
      if (uri != null) {
        await controller.loadRequest(uri);
      } else if (htmlString != null) {
        await controller.loadHtmlString(htmlString);
      } else if (htmlFile != null) {
        await controller.loadFile(htmlFile);
      } else if (assetFile != null) {
        await controller.loadFlutterAsset(assetFile);
      }
      await onInitLoaded?.call();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final fullScreen = widget.fullScreen;

    double getHeight(BoxConstraints constraints) {
      final maxHeight = constraints.maxHeight;
      double height = 0.0;
      if (fullScreen) {
        height = maxHeight;
      } else {
        height = (maxHeight.isInfinite) ? 0.0 : maxHeight;
      }
      return height;
    }

    late WebViewWidget webViewWidget;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      webViewWidget = WebViewWidget(
        controller: controller.webViewController,
      );
    } else {
      webViewWidget = WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: controller.webViewController.platform,
          displayWithHybridComposition: widget.useHybridComposition,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: math.max(getHeight(constraints), _contentHeight),
          child: Stack(
            children: [
              webViewWidget,
              !_loaded
                  ? Align(
                      alignment: Alignment.center,
                      child: widget.onLoaderBuilder?.call() ?? Container(),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Future<NavigationDecision> navigationURLToLinkEvent(String url) async {
    final onNavigationDecision = widget.onNavigationDecision;
    if (url.contains('mailto:')) {
      Logging.d('[LFWebView] navigationDelegate :: Mailto clicked! = $url');
      final _ = onNavigationDecision?.call(LFWebViewEventType.mailto, url);
      return NavigationDecision.prevent;
    } else if (url.contains('tel:')) {
      Logging.d('[LFWebView] navigationDelegate :: Tel clicked! = $url');
      final _ = onNavigationDecision?.call(LFWebViewEventType.tel, url);
      return NavigationDecision.prevent;
    } else if (url.contains('geo:')) {
      Logging.d('[LFWebView] navigationDelegate :: GEO clicked! = $url');
      final _ = onNavigationDecision?.call(LFWebViewEventType.geo, url);
      return NavigationDecision.prevent;
    }
    if (onNavigationDecision != null) {
      final allow = onNavigationDecision.call(null, url);
      return allow ? NavigationDecision.navigate : NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  Future<void> updateWebViewHeightAfterOnPageFinished() async {
    final controller = widget.controller;
    final webViewController = controller.webViewController;
    final readyState = await webViewController
        .runJavaScriptReturningResult('document.readyState');
    Logging.d('[LFWebView] readyState: $readyState');
    if (readyState == 'complete' || readyState == '"complete"') {
      final height = await webViewController
          .runJavaScriptReturningResult('document.body.scrollHeight');
      final heightStr = height.toString();
      final documentHeight = double.parse(heightStr);
      Logging.d('[LFWebView] DocumentHeight: $documentHeight');
      final fullScreen = widget.fullScreen;
      if (!fullScreen) {
        setState(() {
          _contentHeight = documentHeight;
        });
      }
      widget.onHeightFinished?.call(documentHeight);
    }
    setState(() {
      _loaded = true;
    });
  }
}
