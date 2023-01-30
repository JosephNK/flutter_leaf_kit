part of lf_webview;

typedef LFWebViewOnMessageReceived = Function(String name, Map jsonData);
typedef LFWebViewOnHeightFinished = Function(double height);

class LFWebView extends StatefulWidget {
  final String url;
  final bool fullScreen;
  final double initHeight;
  final LFWebViewOnMessageReceived? onMessageReceived;
  final LFWebViewOnHeightFinished? onHeightFinished;

  const LFWebView({
    Key? key,
    required this.url,
    this.fullScreen = true,
    this.initHeight = 0.0,
    this.onMessageReceived,
    this.onHeightFinished,
  }) : super(key: key);

  @override
  State<LFWebView> createState() => _LFWebViewState();
}

class _LFWebViewState extends State<LFWebView> {
  late WebViewController _webViewController;

  double _contentHeight = 0.0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller
      ..loadRequest(Uri.parse('about:blank'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            Logging.d('[WebView] Page started loading: $url');
          },
          onPageFinished: (String url) async {
            Logging.d('[WebView] Page finished loading: $url');
            await changeWebViewHeightAfterLoading();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Logging.d('[WebView] navigationDelegate = ${request.url}');
            final r = await navigationURLToLinkEvent(request.url);
            return r;
          },
        ),
      );

    controller.addJavaScriptChannel(
      'ChannelName',
      onMessageReceived: (JavaScriptMessage message) async {
        final jsonData = jsonDecode(message.message);
        widget.onMessageReceived?.call('ChannelName', jsonData);
      },
    );

    _webViewController = controller;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _webViewController.loadRequest(Uri.parse(widget.url));
    });

    _contentHeight = widget.initHeight;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logging.d('WebView URL: ${widget.url}');
    final fullScreen = widget.fullScreen;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        double height = 0.0;
        if (fullScreen) {
          height = maxHeight;
        } else {
          height = (maxHeight.isInfinite) ? 0.0 : maxHeight;
        }
        return SizedBox(
          height: max(height, _contentHeight),
          child: Stack(
            children: [
              WebViewWidget(
                controller: _webViewController,
              ),
              !_loaded
                  ? const Align(
                      alignment: Alignment.center,
                      child: LFIndicator(),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Future<NavigationDecision> navigationURLToLinkEvent(String url) async {
    Logging.d('navigationURLToLinkEvent: $url');
    if (url.contains('mailto:')) {
      Logging.d('[WebView] navigationDelegate :: Mailto clicked! = $url');
      return NavigationDecision.prevent;
    } else if (url.contains('tel:')) {
      Logging.d('[WebView] navigationDelegate :: Tel clicked! = $url');
      return NavigationDecision.prevent;
    } else if (url.contains('geo:')) {
      Logging.d('[WebView] navigationDelegate :: GEO clicked! = $url');
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  Future<void> changeWebViewHeightAfterLoading() async {
    final controller = _webViewController;
    final readyState =
        await controller.runJavaScriptReturningResult('document.readyState');
    Logging.d('[WebView] readyState: $readyState');
    if (readyState == 'complete' || readyState == '"complete"') {
      final height = await controller
          .runJavaScriptReturningResult('document.body.scrollHeight');
      final heightStr = height.toString();
      final documentHeight = double.parse(heightStr);
      Logging.d('[WebView] height: $documentHeight');
      setState(() {
        _loaded = true;
      });
      final fullScreen = widget.fullScreen;
      if (!fullScreen) {
        setState(() {
          _contentHeight = documentHeight;
        });
        widget.onHeightFinished?.call(documentHeight);
      }
    }
  }
}
