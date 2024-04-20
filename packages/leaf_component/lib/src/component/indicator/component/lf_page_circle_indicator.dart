part of '../lf_indicator.dart';

enum LFPageCircleIndicatorStyle { none, decrease }

class LFPageCircleIndicator extends StatelessWidget {
  final int total;
  final double current;
  final EdgeInsets margin;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final LFPageCircleIndicatorStyle indicatorStyle;

  const LFPageCircleIndicator({
    super.key,
    required this.total,
    required this.current,
    this.margin = const EdgeInsets.all(0.0),
    this.activeColor,
    this.inactiveColor,
    this.size = 4.0,
    this.indicatorStyle = LFPageCircleIndicatorStyle.none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: margin,
      height: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: dots,
      ),
    );
  }

  int get findActiveIndex {
    int activeIndex = 0;
    for (int i = 0; i < total; i++) {
      final active = (i == current.round());
      if (active) {
        activeIndex = i;
        break;
      }
    }
    return activeIndex;
  }

  List<Widget> get dots {
    final activeIndex = findActiveIndex;
    List<Widget> dots = [];
    for (int i = 0; i < total; i++) {
      double size = this.size;
      if (indicatorStyle == LFPageCircleIndicatorStyle.decrease) {
        final diff = ((activeIndex - i).abs()) / 10.0;
        size = size - (size * diff);
      }
      dots.add(LFPageCircleDot(
        active: i == activeIndex,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        size: size,
      ));
    }
    return dots;
  }
}

class LFPageCircleDot extends StatelessWidget {
  final bool active;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const LFPageCircleDot({
    super.key,
    required this.active,
    this.activeColor,
    this.inactiveColor,
    this.size = 4.0,
  });

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
