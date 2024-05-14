part of '../button.dart';

class LFLockGestureDetector extends StatefulWidget {
  final Widget child;
  final Duration lockDuration;
  final bool forceLock;
  final VoidCallback? onTap;

  const LFLockGestureDetector({
    super.key,
    required this.child,
    this.lockDuration = const Duration(milliseconds: 250),
    this.forceLock = false,
    this.onTap,
  });

  @override
  State<LFLockGestureDetector> createState() => _LFLockGestureDetectorState();
}

class _LFLockGestureDetectorState extends State<LFLockGestureDetector> {
  Timer? _timer;
  bool _lock = false;
  bool _forceLock = false;

  @override
  void initState() {
    _forceLock = widget.forceLock;

    super.initState();
  }

  @override
  void dispose() {
    _stopLockTimer();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFLockGestureDetector oldWidget) {
    if (oldWidget.forceLock != widget.forceLock) {
      _forceLock = widget.forceLock;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_lock || _forceLock) {
          return;
        }
        if (!_forceLock) {
          _startLockTimer();
        }
        widget.onTap?.call();
      },
      child: widget.child,
    );
  }

  void _startLockTimer() {
    _lock = true;
    _timer?.cancel();
    _timer = Timer(widget.lockDuration, () {
      _lock = false;
    });
  }

  void _stopLockTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
