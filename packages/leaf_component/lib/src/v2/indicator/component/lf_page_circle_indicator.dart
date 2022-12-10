part of lf_indicator;

class LFPageCircleIndicator extends StatelessWidget {
  final int total;
  final double current;
  final EdgeInsets margin;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const LFPageCircleIndicator({
    Key? key,
    required this.total,
    required this.current,
    this.margin = const EdgeInsets.all(0.0),
    this.activeColor,
    this.inactiveColor,
    this.size = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: margin,
      height: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < total; i++)
            if (i == current.round()) ...[
              LFPageCircleDot(
                active: true,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                size: size,
              ),
            ] else ...[
              LFPageCircleDot(
                active: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                size: size,
              ),
            ]
        ],
      ),
    );
  }
}

class LFPageCircleDot extends StatelessWidget {
  final bool active;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const LFPageCircleDot({
    Key? key,
    required this.active,
    this.activeColor,
    this.inactiveColor,
    this.size = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: active
            ? activeColor ?? Colors.blueAccent
            : inactiveColor ?? Colors.grey,
      ),
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: size,
      height: size,
    );
  }
}
