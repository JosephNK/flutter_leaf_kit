part of lf_container;

class LFRotateContainer extends StatefulWidget {
  final Widget child;
  final bool rotate;

  const LFRotateContainer({
    Key? key,
    required this.child,
    required this.rotate,
  }) : super(key: key);

  @override
  State<LFRotateContainer> createState() => _LFRotateContainerState();
}

class _LFRotateContainerState extends State<LFRotateContainer>
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
  void didUpdateWidget(covariant LFRotateContainer oldWidget) {
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
