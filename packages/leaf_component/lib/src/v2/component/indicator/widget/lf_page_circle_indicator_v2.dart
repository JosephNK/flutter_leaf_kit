import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// Style for circle indicator dot sizing behaviour.
enum LFPageCircleIndicatorStyleV2 { none, decrease }

/// A themed circle-style page indicator.
///
/// Shows the current page position with animated circle dots.
@immutable
class LFPageCircleIndicatorV2 extends StatelessWidget {
  final int total;
  final double current;
  final EdgeInsets margin;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final LFPageCircleIndicatorStyleV2 indicatorStyle;

  const LFPageCircleIndicatorV2({
    super.key,
    required this.total,
    required this.current,
    this.margin = EdgeInsets.zero,
    this.activeColor,
    this.inactiveColor,
    this.size = 4.0,
    this.indicatorStyle = LFPageCircleIndicatorStyleV2.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;

    final resolvedActive = activeColor ?? colors.primary;
    final resolvedInactive = inactiveColor ?? colors.inactive;

    return Semantics(
      label: 'Page ${current.round() + 1} of $total',
      child: Container(
        color: Colors.transparent,
        margin: margin,
        height: 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _buildDots(resolvedActive, resolvedInactive),
        ),
      ),
    );
  }

  int get _activeIndex {
    for (int i = 0; i < total; i++) {
      if (i == current.round()) return i;
    }
    return 0;
  }

  List<Widget> _buildDots(Color activeColor, Color inactiveColor) {
    final activeIndex = _activeIndex;
    final dots = <Widget>[];

    for (int i = 0; i < total; i++) {
      double dotSize = size;
      if (indicatorStyle == LFPageCircleIndicatorStyleV2.decrease) {
        final diff = ((activeIndex - i).abs()) / 10.0;
        dotSize = size - (size * diff);
        if (dotSize < 1.0) dotSize = 0.0;
      }
      if (dotSize > 0.0) {
        dots.add(AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dotSize),
            color: i == activeIndex ? activeColor : inactiveColor,
          ),
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: dotSize,
          height: dotSize,
        ));
      }
    }
    return dots;
  }
}
