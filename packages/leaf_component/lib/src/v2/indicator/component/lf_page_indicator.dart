part of lf_indicator;

class LFPageIndicator extends StatelessWidget {
  final int total;
  final double current;
  final EdgeInsets margin;
  final Color? activeColor;
  final Color? inactiveColor;

  const LFPageIndicator({
    Key? key,
    required this.total,
    required this.current,
    this.margin = const EdgeInsets.all(0.0),
    this.activeColor,
    this.inactiveColor,
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
              LFPageDot(
                active: true,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ] else ...[
              LFPageDot(
                active: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ]
        ],
      ),
    );
  }
}

class LFPageDot extends StatelessWidget {
  final bool active;
  final Color? activeColor;
  final Color? inactiveColor;

  const LFPageDot({
    Key? key,
    required this.active,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: active
            ? activeColor ?? Colors.blueAccent
            : inactiveColor ?? Colors.grey,
      ),
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: active ? 16.0 : 4.0,
      height: active ? 4.0 : 4.0,
    );
  }
}
