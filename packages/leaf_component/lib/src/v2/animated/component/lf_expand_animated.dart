part of lf_animated;

class LFExpandAnimated extends StatefulWidget {
  final Widget child;
  final bool expand;

  const LFExpandAnimated({
    Key? key,
    required this.child,
    required this.expand,
  }) : super(key: key);

  @override
  State<LFExpandAnimated> createState() => _LFExpandAnimatedState();
}

class _LFExpandAnimatedState extends State<LFExpandAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _duration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
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
