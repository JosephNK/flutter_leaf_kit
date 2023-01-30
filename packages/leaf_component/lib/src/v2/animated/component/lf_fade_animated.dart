part of lf_animated;

class LFFadeAnimated extends StatefulWidget {
  final LFFadeAnimationController controller;
  final Widget child;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFFadeAnimated({
    Key? key,
    required this.controller,
    required this.child,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFFadeAnimated> createState() => _LFFadeAnimatedState();
}

class _LFFadeAnimatedState extends State<LFFadeAnimated>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final repeatCount = controller.repeatCount;
    final autoAnimation = controller.autoAnimation;
    final isDisappear = controller.isDisappear;
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

    if (!isDisappear) {
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    } else {
      _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    }
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
  void didUpdateWidget(covariant LFFadeAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  void animationCallback(AnimationStatus status) {
    // if (status == AnimationStatus.completed) print('completed');
    widget.onAnimationStatus?.call(status);
  }
}
