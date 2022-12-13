part of lf_animated;

class LFRotateAnimated extends StatefulWidget {
  final Widget child;
  final bool rotate;

  const LFRotateAnimated({
    Key? key,
    required this.child,
    required this.rotate,
  }) : super(key: key);

  @override
  State<LFRotateAnimated> createState() => _LFRotateAnimatedState();
}

class _LFRotateAnimatedState extends State<LFRotateAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween(begin: 0.0, end: -pi).animate(_animationController);

    if (widget.rotate) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFRotateAnimated oldWidget) {
    if (oldWidget.rotate != widget.rotate) {
      if (widget.rotate) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
