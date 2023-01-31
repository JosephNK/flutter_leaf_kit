part of lf_animated;

class LFExpandAnimated extends StatefulWidget {
  final Widget child;
  final LFExpandAnimationController? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFExpandAnimated({
    Key? key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFExpandAnimated> createState() => _LFExpandAnimatedState();
}

class _LFExpandAnimatedState extends State<LFExpandAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFExpandAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFExpandAnimationController(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final controller = _innerController;
    final autoAnimation = controller.autoAnimation;
    final duration = controller.duration;
    final animationController = controller.initAnimationController(
      AnimationController(vsync: this, duration: duration),
    );
    _animationController = animationController;

    controller.addListener(() async {
      final status = controller.status;
      switch (status) {
        case LFAnimationStatus.forward:
          break;
        case LFAnimationStatus.stop:
          break;
        case LFAnimationStatus.reverse:
          break;
        case LFAnimationStatus.repeat:
          break;
      }
    });

    _animation =
        CurvedAnimation(parent: animationController!, curve: Curves.ease);
    _animation.addStatusListener(animationCallback);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (autoAnimation) {
        runAutoAnimating();
      } else {
        runManualAnimating();
      }
    });
  }

  @override
  void dispose() {
    _animation.removeStatusListener(animationCallback);
    _animationController?.stop();
    _animationController?.dispose();
    if (widget.controller == null) _innerController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFExpandAnimated oldWidget) {
    if (oldWidget.value != widget.value) {
      runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final expand = controller?.status == LFAnimationStatus.forward;

    /// https://stackoverflow.com/a/72734746
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: (expand) ? 1.0 : -1.0,
      sizeFactor: _animation,
      child: widget.child,
    );
  }

  void animationCallback(AnimationStatus status) {
    widget.onAnimationStatus?.call(status);
  }

  void runAutoAnimating() {
    final controller = widget.controller ?? _innerController;
    final repeatCount = controller.repeatCount;
    if (repeatCount != -1) {
      controller.repeat();
    } else {
      controller.forward();
    }
  }

  void runManualAnimating() {
    final controller = widget.controller ?? _innerController;
    final value = widget.value;
    if (value != null) {
      if (value) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }
}
