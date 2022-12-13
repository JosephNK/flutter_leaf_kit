part of lf_animated;

class LFFadeAnimated extends StatefulWidget {
  final Widget child;

  const LFFadeAnimated({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LFFadeAnimated> createState() => _LFFadeAnimatedState();
}

class _LFFadeAnimatedState extends State<LFFadeAnimated>
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
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

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
}
