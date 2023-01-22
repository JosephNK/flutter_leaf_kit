part of lf_animated;

class LFFadeAnimated extends StatefulWidget {
  final Widget child;
  final bool fade;
  final Duration duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFFadeAnimated({
    Key? key,
    required this.child,
    this.fade = true,
    this.duration = const Duration(milliseconds: 1000),
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFFadeAnimated> createState() => _LFFadeAnimatedState();
}

class _LFFadeAnimatedState extends State<LFFadeAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.fade) {
      _animation =
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    } else {
      _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    }

    _animation.addStatusListener(animationCallback);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animation.removeStatusListener(animationCallback);
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFFadeAnimated oldWidget) {
    // if (oldWidget.fade != widget.fade) {
    //   if (widget.fade) {
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
