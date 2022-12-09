part of lf_popsope_component;

typedef LFPopScopeCallback = Future<void> Function();

class LFPopScopeToAppClose extends StatefulWidget {
  final Widget child;
  final LFPopScopeCallback? callback;
  final Duration duration;
  final bool enableBack;
  final VoidCallback? onWillPop;

  const LFPopScopeToAppClose({
    Key? key,
    required this.child,
    required this.callback,
    this.duration = const Duration(milliseconds: 4000),
    this.enableBack = false,
    this.onWillPop,
  }) : super(key: key);

  @override
  State<LFPopScopeToAppClose> createState() => _LFPopScopeToAppCloseState();
}

class _LFPopScopeToAppCloseState extends State<LFPopScopeToAppClose> {
  DateTime? _lastTimeBackButtonWasTapped;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  bool get _isSnackBarVisible {
    final lastTimeBackButtonWasTapped = _lastTimeBackButtonWasTapped;
    return (lastTimeBackButtonWasTapped != null) &&
        (widget.duration >
            DateTime.now().difference(lastTimeBackButtonWasTapped));
  }

  bool get _willHandlePopInternally =>
      ModalRoute.of(context)?.willHandlePopInternally ?? false;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: () {
          if (widget.enableBack) {
            return Future<bool>.value(true);
          }
          return _handleWillPop(context);
        },
        child: widget.child,
      );
    }
    return widget.child;
  }

  Future<bool> _handleWillPop(BuildContext context) async {
    if (_isSnackBarVisible || _willHandlePopInternally) {
      //return true;
      // exit(0);
      // await Future.delayed(Duration(milliseconds: 1000));
      // await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now();
      await widget.callback?.call();
      widget.onWillPop?.call();
      return false;
    }
  }
}
