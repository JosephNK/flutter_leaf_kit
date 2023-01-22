part of lf_animated;

class LFScaleAnimated extends StatefulWidget {
  final Widget child;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFScaleAnimated({
    Key? key,
    required this.child,
    this.onAnimationStatus,
  }) : super(key: key);

  @override
  State<LFScaleAnimated> createState() => _LFScaleAnimatedState();
}

class _LFScaleAnimatedState extends State<LFScaleAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);

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
  void didUpdateWidget(covariant LFScaleAnimated oldWidget) {
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
    // if (status == AnimationStatus.completed) print('completed');
    widget.onAnimationStatus?.call(status);
  }
}
