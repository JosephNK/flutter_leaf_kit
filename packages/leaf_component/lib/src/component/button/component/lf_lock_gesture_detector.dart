part of '../button.dart';

typedef LFLockGestureDetectorOnLoaderBuilder = Widget Function();

class LFLockGestureDetector extends StatefulWidget {
  final Widget child;
  final Duration lockDuration;
  final bool forceLock;
  final bool loading;
  final bool showLoading;
  final bool disabled;
  final BoxDecoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final LFLockGestureDetectorOnLoaderBuilder? onLoaderBuilder;
  final VoidCallback? onTap;

  const LFLockGestureDetector({
    super.key,
    required this.child,
    this.lockDuration = const Duration(milliseconds: 250),
    this.forceLock = false,
    this.loading = false,
    this.showLoading = true,
    this.disabled = false,
    this.decoration,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onLoaderBuilder,
    this.onTap,
  });

  @override
  State<LFLockGestureDetector> createState() => _LFLockGestureDetectorState();
}

class _LFLockGestureDetectorState extends State<LFLockGestureDetector> {
  Timer? _timer;
  bool _lock = false;
  bool _forceLock = false;
  bool _loading = false;
  bool _disabled = false;

  @override
  void initState() {
    _forceLock = widget.forceLock;
    _loading = widget.loading;
    _disabled = widget.disabled;

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
    if (oldWidget.loading != widget.loading) {
      setState(() {
        _loading = widget.loading;
      });
    }
    if (oldWidget.disabled != widget.disabled) {
      setState(() {
        _disabled = widget.disabled;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    Widget? loadingWidget = widget.onLoaderBuilder?.call();

    Clip clipBehavior = Clip.hardEdge;
    List<Positioned> positionedWidgets = [];
    if (child is Stack) {
      clipBehavior = child.clipBehavior;
      positionedWidgets = child.children
          .map((e) => e is Positioned ? e : null)
          .whereNotNull()
          .toList();
      child = Stack(
        clipBehavior: clipBehavior,
        children: [
          ...child.children
              .map((e) => e is! Positioned ? e : null)
              .whereNotNull(),
        ],
      );
    }

    return Container(
      margin: widget.margin,
      child: LFInkWell(
        decoration: widget.decoration,
        borderRadius: widget.borderRadius,
        disabled: _disabled,
        onTap: () {
          if (_lock || _forceLock) {
            return;
          }
          if (!_forceLock) {
            _startLockTimer();
          }
          widget.onTap?.call();
        },
        child: Stack(
          clipBehavior: clipBehavior,
          children: [
            Container(
              padding: widget.padding,
              child: child,
            ),
            Positioned.fill(
              child: Visibility(
                visible: _loading,
                child: Center(
                  child: loadingWidget ??
                      const LFIndicator(
                        size: LFIndicatorSize.small,
                      ),
                ),
              ),
            ),
            ...positionedWidgets,
          ],
        ),
      ),
    );
  }

  void _startLockTimer() {
    _toggleLoading(true);
    _lock = true;
    _timer?.cancel();
    _timer = Timer(widget.lockDuration, () {
      _toggleLoading(false);
      _lock = false;
    });
  }

  void _stopLockTimer() {
    _toggleLoading(false);
    _timer?.cancel();
    _timer = null;
  }

  void _toggleLoading(bool loading) {
    if (widget.showLoading && context.mounted) {
      setState(() {
        _loading = loading;
      });
    }
  }
}
