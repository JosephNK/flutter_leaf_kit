part of lf_animated;

class LFScaleAnimated extends StatefulWidget {
  final Widget child;
  final LFScaleAnimationController? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFScaleAnimated({
    Key? key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFScaleAnimated> createState() => _LFScaleAnimatedState();
}

class _LFScaleAnimatedState extends State<LFScaleAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFScaleAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFScaleAnimationController(
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

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.easeInOutBack));

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
  void didUpdateWidget(covariant LFScaleAnimated oldWidget) {
    if (oldWidget.value != widget.value) {
      runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
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
