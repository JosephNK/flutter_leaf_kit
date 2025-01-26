import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class WebViewScreen extends ScreenStatefulWidget {
  final String title;

  const WebViewScreen({
    super.key,
    required this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends ScreenState<WebViewScreen> {
  late LFWebViewController _webViewController;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    _webViewController = LFWebViewController();
    _webViewController.addJavaScriptChannel(
      'CHANEL_NAME',
      onMessageReceived: (message) {
        final jsonData = jsonDecode(message.message);
        Logging.i('onMessageReceived: $jsonData');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _webViewController.dispose();
  }

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return LFWebView(
      controller: _webViewController,
      onLoaded: () {
        _webViewController.loadRequest(
          Uri.parse('https://flutter.dev/'),
        );
      },
      useHybridComposition: false,
      onLoaderBuilder: () {
        return const LFIndicator();
      },
    );
  }
}
