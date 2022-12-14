part of lf_animated;

class LFBouncingAnimated extends StatefulWidget {
  final Widget child;

  const LFBouncingAnimated({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LFBouncingAnimated> createState() => _LFBouncingAnimatedState();
}

class _LFBouncingAnimatedState extends State<LFBouncingAnimated>
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
    _animation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticIn),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {}
      });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _animationController.forward();
      await _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

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
}
