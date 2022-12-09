part of lf_webview;

typedef LFWebViewOnMessageReceived = Function(String name, Map jsonData);
typedef LFWebViewOnHeightFinished = Function(double height);

class LFWebView extends StatefulWidget {
  final String? url;
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
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  double _contentHeight = 0.0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();

    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

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
              WebView(
                initialUrl: widget.url,
                // initialUrl: 'about:blank',
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>{
                  JavascriptChannel(
                    name: 'ChannelName',
                    onMessageReceived: (JavascriptMessage message) async {
                      final jsonData = jsonDecode(message.message);
                      widget.onMessageReceived?.call('ChannelName', jsonData);
                    },
                  ),
                },
                navigationDelegate: (NavigationRequest request) async {
                  Logging.d('[WebView] navigationDelegate = ${request.url}');
                  final r = await navigationURLToLinkEvent(request.url);
                  return r;
                },
                onPageStarted: (String url) {
                  Logging.d('[WebView] Page started loading: $url');
                },
                onPageFinished: (String url) async {
                  Logging.d('[WebView] Page finished loading: $url');
                  await changeWebViewHeightAfterLoading();
                },
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
    final controller = await _controller.future;
    final readyState =
        await controller.runJavascriptReturningResult('document.readyState');
    Logging.d('[WebView] readyState: $readyState');
    if (readyState == 'complete' || readyState == '"complete"') {
      final height = await controller
          .runJavascriptReturningResult('document.body.scrollHeight');
      final documentHeight = double.parse(height);
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
