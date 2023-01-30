part of lf_animated;

class LFBouncingAnimated extends StatefulWidget {
  final LFBouncingAnimationController controller;
  final Widget child;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFBouncingAnimated({
    Key? key,
    required this.controller,
    required this.child,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFBouncingAnimated> createState() => _LFBouncingAnimatedState();
}

class _LFBouncingAnimatedState extends State<LFBouncingAnimated>
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

    _animation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticIn),
    );
    _animation.addStatusListener(animationCallback);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (autoAnimation) {
        if (repeatCount != -1) {
          controller.repeat();
        } else {
          await controller.forward();
          await controller.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _animation.removeStatusListener(animationCallback);
    // _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFBouncingAnimated oldWidget) {
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
}
