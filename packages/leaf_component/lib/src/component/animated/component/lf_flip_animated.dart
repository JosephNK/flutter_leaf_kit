part of lf_animated;

class LFFlipAnimated extends StatefulWidget {
  final Widget front;
  final Widget rear;
  final bool showFrontSide;
  final ValueChanged<bool>? onChanged;

  const LFFlipAnimated({
    Key? key,
    required this.front,
    required this.rear,
    this.showFrontSide = true,
    this.onChanged,
  }) : super(key: key);

  @override
  State<LFFlipAnimated> createState() => _LFFlipAnimatedState();
}

class _LFFlipAnimatedState extends State<LFFlipAnimated> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();

    _showFrontSide = widget.showFrontSide;
    _flipXAxis = true;
  }

  @override
  void didUpdateWidget(covariant LFFlipAnimated oldWidget) {
    if (oldWidget.showFrontSide != widget.showFrontSide) {
      setState(() {
        _showFrontSide = widget.showFrontSide;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation();
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final value = !_showFrontSide;
        setState(() {
          _showFrontSide = value;
        });
        widget.onChanged?.call(value);
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
        isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront() {
    return Container(
      key: const ValueKey(true),
      child: widget.front,
    );
  }

  Widget _buildRear() {
    return Container(
      key: const ValueKey(false),
      child: widget.rear,
    );
  }
}
