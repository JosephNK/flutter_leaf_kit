part of '../popscope.dart';

typedef LFPopScopeCallback = Future<void> Function();

class LFPopScopeToAppClose extends StatefulWidget {
  final Widget child;
  final LFPopScopeCallback? closeBeforeCallback;
  final Duration duration;
  final VoidCallback? onWillPop;

  const LFPopScopeToAppClose({
    super.key,
    required this.child,
    required this.closeBeforeCallback,
    this.duration = const Duration(milliseconds: 4000),
    this.onWillPop,
  });

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

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (Platform.isAndroid) {
            // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop') wrong behavior in Android 12 when using FlutterFragmentActivity
            // https://github.com/flutter/flutter/issues/98133
            final sdkInt = await LFDeviceManager.shared.getAndroidSdkInt();
            if (sdkInt >= 31) return;
          }
          // ignore: use_build_context_synchronously
          _handleWillPop(context);
        },
        child: widget.child,
      );
    }
    return widget.child;
  }

  Future<bool> _handleWillPop(BuildContext context) async {
    bool willHandlePopInternally =
        ModalRoute.of(context)?.willHandlePopInternally ?? false;
    if (_isSnackBarVisible || willHandlePopInternally) {
      if (_isAndroid) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
        // exit(0);
      }
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now();
      await widget.closeBeforeCallback?.call();
      widget.onWillPop?.call();
      return false;
    }
  }
}
