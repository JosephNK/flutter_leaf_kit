part of lf_animated;

class LFScaleAnimated extends StatefulWidget {
  final Widget child;

  const LFScaleAnimated({
    Key? key,
    required this.child,
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

    _animationController.forward();
  }

  @override
  void dispose() {
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
}
