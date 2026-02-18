part of 'leaf_webview.dart';

enum LeafWebViewEventType { mailto, tel, geo }

typedef LeafWebViewOnBeforeLoaded = Function();
typedef LeafWebViewOnLoaded = Function();
typedef LeafWebViewOnLoaderBuilder = Widget Function();
typedef LeafWebViewOnCreateWebViewController =
    Function(WebViewController webViewController);
typedef LeafWebViewOnPageStarted = Function();
typedef LeafWebViewOnPageFinished = Function();
typedef LeafWebViewOnHeightFinished = Function(double height);
typedef LeafWebViewOnNavigationDecision =
    bool Function(LeafWebViewEventType? type, String url);
typedef LeafWebViewOnUrlChange = Function(String? url);
typedef LeafWebViewOnHttpError = Function(HttpResponseError error);
typedef LeafWebViewOnJavaScriptAlertDialogIOS =
    Future<bool?> Function(JavaScriptAlertDialogRequest request);
typedef LeafWebViewOnJavaScriptConfirmDialogIOS =
    Future<bool?> Function(JavaScriptConfirmDialogRequest request);
typedef LeafWebViewOnJavaScriptTextInputDialogIOS =
    Future<String?> Function(JavaScriptTextInputDialogRequest request);

class LeafWebView extends StatefulWidget {
  final LeafWebViewController controller;
  final Uri? uri;
  final String? htmlString;
  final String? htmlFile;
  final String? assetFile;
  final bool fullScreen;
  final double initHeight;
  final Color backgroundColor;
  final bool allowAllowOrientation;
  final bool allowsBackForwardNavigationGestures;
  final bool useHybridComposition;
  final bool isInspectable;
  final String? userAgent;
  final Duration? loaderDelay;
  final LeafWebViewOnBeforeLoaded? onInitBeforeLoaded;
  final LeafWebViewOnLoaded? onInitLoaded;
  final LeafWebViewOnCreateWebViewController? onCreateWebViewController;
  final LeafWebViewOnPageStarted? onPageStarted;
  final LeafWebViewOnPageFinished? onPageFinished;
  final LeafWebViewOnLoaderBuilder? onLoaderBuilder;
  final LeafWebViewOnHeightFinished? onHeightFinished;
  final LeafWebViewOnNavigationDecision? onNavigationDecision;
  final LeafWebViewOnUrlChange? onUrlChange;
  final LeafWebViewOnHttpError? onHttpError;
  final LeafWebViewOnJavaScriptAlertDialogIOS? onJavaScriptAlertDialogIOS;
  final LeafWebViewOnJavaScriptConfirmDialogIOS? onJavaScriptConfirmDialogIOS;
  final LeafWebViewOnJavaScriptTextInputDialogIOS?
  onJavaScriptTextInputDialogIOS;

  const LeafWebView({
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
    this.allowsBackForwardNavigationGestures = true,
    this.useHybridComposition = false,
    this.isInspectable = false,
    this.userAgent,
    this.loaderDelay,
    this.onInitBeforeLoaded,
    this.onInitLoaded,
    this.onLoaderBuilder,
    this.onCreateWebViewController,
    this.onPageStarted,
    this.onPageFinished,
    this.onHeightFinished,
    this.onNavigationDecision,
    this.onUrlChange,
    this.onHttpError,
    this.onJavaScriptAlertDialogIOS,
    this.onJavaScriptConfirmDialogIOS,
    this.onJavaScriptTextInputDialogIOS,
  });

  @override
  State<LeafWebView> createState() => _LeafWebViewState();
}

class _LeafWebViewState extends State<LeafWebView> {
  late NavigationDelegate _navigationDelegate;

  double _contentHeight = 0.0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final initHeight = widget.initHeight;
    final backgroundColor = widget.backgroundColor;
    final allowAllowOrientation = widget.allowAllowOrientation;
    final allowsBackForwardNavigationGestures =
        widget.allowsBackForwardNavigationGestures;
    final isInspectable = widget.isInspectable;
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
    final onJavaScriptAlertDialogIOS = widget.onJavaScriptAlertDialogIOS;
    final onJavaScriptConfirmDialogIOS = widget.onJavaScriptConfirmDialogIOS;
    final onJavaScriptTextInputDialogIOS =
        widget.onJavaScriptTextInputDialogIOS;

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

    if (webViewController.platform is WebKitWebViewController) {
      WebKitWebViewController iOSWebViewController =
          (webViewController.platform as WebKitWebViewController);
      iOSWebViewController.setAllowsBackForwardNavigationGestures(
        allowsBackForwardNavigationGestures,
      );
      iOSWebViewController.setInspectable(isInspectable);
      if (onJavaScriptAlertDialogIOS != null) {
        iOSWebViewController.setOnJavaScriptAlertDialog((
          JavaScriptAlertDialogRequest request,
        ) async {
          await onJavaScriptAlertDialogIOS.call(request);
        });
      }
      if (onJavaScriptConfirmDialogIOS != null) {
        iOSWebViewController.setOnJavaScriptConfirmDialog((
          JavaScriptConfirmDialogRequest request,
        ) async {
          final result = await onJavaScriptConfirmDialogIOS.call(request);
          return result ?? false;
        });
      }
      if (onJavaScriptTextInputDialogIOS != null) {
        iOSWebViewController.setOnJavaScriptTextInputDialog((
          JavaScriptTextInputDialogRequest request,
        ) async {
          final result = await onJavaScriptTextInputDialogIOS.call(request);
          return result ?? '';
        });
      }
    }

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
        LeafLogging.d('[LeafWebView] onProgress = ${progress.toString()}');
      },
      onPageStarted: (String url) {
        LeafLogging.d('[LeafWebView] onPageStarted = $url');
        setState(() {
          _loading = true;
        });
        onPageStarted?.call();
      },
      onPageFinished: (String url) async {
        LeafLogging.d('[LeafWebView] onPageFinished = $url');
        await updateWebViewHeightAfterOnPageFinished();
        onPageFinished?.call();
      },
      onWebResourceError: (WebResourceError error) {
        LeafLogging.d('[LeafWebView] onWebResourceError = ${error.errorCode}');
      },
      onNavigationRequest: (NavigationRequest request) async {
        LeafLogging.d('[LeafWebView] navigationDelegate = ${request.url}');
        return await navigationURLToLinkEvent(request.url);
      },
      onHttpAuthRequest: (HttpAuthRequest request) async {
        LeafLogging.d('[LeafWebView] onHttpAuthRequest = ${request.realm}');
      },
      onUrlChange: (UrlChange change) {
        LeafLogging.d('[LeafWebView] onUrlChange = ${change.url}');
        widget.onUrlChange?.call(change.url);
      },
      onHttpError: (HttpResponseError error) {
        LeafLogging.d('[LeafWebView] onHttpError = ${error.response}');
        widget.onHttpError?.call(error);
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
          controller.addJavaScriptMessageStream({
            javaScriptChannelName: message,
          });
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
      webViewWidget = WebViewWidget(controller: controller.webViewController);
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
              if (_loading)
                if (Platform.isIOS) ...[
                  Positioned.fill(
                    child: PointerInterceptor(
                      intercepting: true,
                      debug: false,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: widget.onLoaderBuilder?.call() ?? Container(),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Positioned.fill(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: widget.onLoaderBuilder?.call() ?? Container(),
                        ),
                      ),
                    ),
                  ),
                ],
            ],
          ),
        );
      },
    );
  }

  Future<NavigationDecision> navigationURLToLinkEvent(String url) async {
    final onNavigationDecision = widget.onNavigationDecision;
    if (url.contains('mailto:')) {
      LeafLogging.d(
        '[LeafWebView] navigationDelegate :: Mailto clicked! = $url',
      );
      final _ = onNavigationDecision?.call(LeafWebViewEventType.mailto, url);
      return NavigationDecision.prevent;
    } else if (url.contains('tel:')) {
      LeafLogging.d('[LeafWebView] navigationDelegate :: Tel clicked! = $url');
      final _ = onNavigationDecision?.call(LeafWebViewEventType.tel, url);
      return NavigationDecision.prevent;
    } else if (url.contains('geo:')) {
      LeafLogging.d('[LeafWebView] navigationDelegate :: GEO clicked! = $url');
      final _ = onNavigationDecision?.call(LeafWebViewEventType.geo, url);
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
    final readyState = await webViewController.runJavaScriptReturningResult(
      'document.readyState',
    );
    LeafLogging.d('[LeafWebView] readyState: $readyState');
    if (readyState == 'complete' || readyState == '"complete"') {
      final height = await webViewController.runJavaScriptReturningResult(
        'document.body.scrollHeight',
      );
      final heightStr = height.toString();
      final documentHeight = double.parse(heightStr);
      LeafLogging.d('[LeafWebView] DocumentHeight: $documentHeight');
      final fullScreen = widget.fullScreen;
      if (!fullScreen) {
        if (context.mounted) {
          setState(() {
            _contentHeight = documentHeight;
          });
        }
      }
      widget.onHeightFinished?.call(documentHeight);
    }
    if (context.mounted) {
      final loaderDelay = widget.loaderDelay;
      if (loaderDelay != null) {
        await Future.delayed(loaderDelay);
      }
      setState(() {
        _loading = false;
      });
    }
  }
}
