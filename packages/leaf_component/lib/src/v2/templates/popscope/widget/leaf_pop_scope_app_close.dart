import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Callback invoked before the app-close snackbar timer begins.
typedef LeafPopScopeCallback = Future<void> Function();

/// A widget that intercepts the Android back button to confirm app exit.
///
/// On Android, the first back press fires [onBackPressed] (e.g. show a
/// "press again to exit" snackbar). A second press within [duration]
/// invokes `SystemNavigator.pop()` to close the app.
///
/// On non-Android platforms the [child] is returned without modification.
@immutable
class LeafPopScopeAppClose extends StatefulWidget {
  /// The content below this scope.
  final Widget child;

  /// Called on the first back-press so the host can show a confirmation UI.
  final LeafPopScopeCallback? onBackPressed;

  /// Window in which a second back-press triggers app exit.
  final Duration duration;

  /// Optional callback fired together with [onBackPressed].
  final VoidCallback? onWillPop;

  const LeafPopScopeAppClose({
    super.key,
    required this.child,
    this.onBackPressed,
    this.duration = const Duration(milliseconds: 4000),
    this.onWillPop,
  });

  @override
  State<LeafPopScopeAppClose> createState() => _LeafPopScopeAppCloseState();
}

class _LeafPopScopeAppCloseState extends State<LeafPopScopeAppClose> {
  DateTime? _lastBackPress;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  bool get _isWithinExitWindow {
    final last = _lastBackPress;
    return last != null && widget.duration > DateTime.now().difference(last);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAndroid) return widget.child;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackPress();
      },
      child: widget.child,
    );
  }

  Future<void> _handleBackPress() async {
    final willHandleInternally =
        ModalRoute.of(context)?.willHandlePopInternally ?? false;

    if (_isWithinExitWindow || willHandleInternally) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return;
    }

    _lastBackPress = DateTime.now();
    await widget.onBackPressed?.call();
    widget.onWillPop?.call();
  }
}
