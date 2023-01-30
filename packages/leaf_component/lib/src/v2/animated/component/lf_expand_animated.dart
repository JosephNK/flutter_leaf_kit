part of lf_animated;

class LFExpandAnimated extends StatefulWidget {
  final LFExpandAnimationController controller;
  final Widget child;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFExpandAnimated({
    Key? key,
    required this.controller,
    required this.child,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFExpandAnimated> createState() => _LFExpandAnimatedState();
}

class _LFExpandAnimatedState extends State<LFExpandAnimated>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final repeatCount = controller.repeatCount;
    final autoAnimation = controller.autoAnimation;
    final animationController = controller.initAnimationController(vsync: this);

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
    _animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastLinearToSlowEaseIn);
    _animation.addStatusListener(animationCallback);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (autoAnimation) {
        if (repeatCount != -1) {
          controller.repeat();
        } else {
          controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _animation.removeStatusListener(animationCallback);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFExpandAnimated oldWidget) {
    // if (oldWidget.expand != widget.expand) {
    //   if (widget.expand) {
    //     _animationController.forward();
    //   } else {
    //     _animationController.reverse();
    //     // _animationController.animateBack(0, duration: _duration);
    //   }
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final expand = controller.status == LFAnimationStatus.forward;

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
}
