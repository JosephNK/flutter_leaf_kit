part of lf_animated;

class LFRotateAnimated extends StatefulWidget {
  final LFRotateAnimationController controller;
  final Widget child;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFRotateAnimated({
    Key? key,
    required this.controller,
    required this.child,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFRotateAnimated> createState() => _LFRotateAnimatedState();
}

class _LFRotateAnimatedState extends State<LFRotateAnimated>
    with SingleTickerProviderStateMixin {
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final repeatCount = controller.repeatCount;
    final autoAnimation = controller.autoAnimation;
    final degree = controller.degree;
    final animationController = controller.initAnimationController(vsync: this);

    controller.addListener(() {
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

    _animation = Tween(begin: 0.0, end: degree).animate(animationController);
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
  void didUpdateWidget(covariant LFRotateAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final animationController = controller.animationController;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: widget.child,
        );
      },
    );
  }

  void animationCallback(AnimationStatus status) {
    widget.onAnimationStatus?.call(status);
  }
}
