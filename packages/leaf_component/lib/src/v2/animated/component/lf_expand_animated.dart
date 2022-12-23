part of lf_animated;

class LFExpandAnimated extends StatefulWidget {
  final Widget child;
  final bool expand;
  final Duration duration;
  final Curve curve;

  const LFExpandAnimated({
    Key? key,
    required this.child,
    this.expand = true,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInToLinear,
  }) : super(key: key);

  @override
  State<LFExpandAnimated> createState() => _LFExpandAnimatedState();
}

class _LFExpandAnimatedState extends State<LFExpandAnimated>
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
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    if (widget.expand) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFExpandAnimated oldWidget) {
    if (oldWidget.expand != widget.expand) {
      if (widget.expand) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        // _animationController.animateBack(0, duration: _duration);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    /// https://stackoverflow.com/a/72734746
    return SizeTransition(
      axisAlignment: (widget.expand) ? 1.0 : -1.0,
      sizeFactor: _animation,
      child: Container(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
