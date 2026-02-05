import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// A themed rectangle-style page indicator.
///
/// Active dot expands to a wider rectangle; inactive dots stay small squares.
@immutable
class LFPageRectIndicatorV2 extends StatelessWidget {
  final int total;
  final double current;
  final EdgeInsets margin;
  final Color? activeColor;
  final Color? inactiveColor;

  const LFPageRectIndicatorV2({
    super.key,
    required this.total,
    required this.current,
    this.margin = EdgeInsets.zero,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;

    final resolvedActive = activeColor ?? colors.primary;
    final resolvedInactive = inactiveColor ?? colors.inactive;
    final activeIndex = current.round();

    return Semantics(
      label: 'Page ${activeIndex + 1} of $total',
      child: Container(
        color: Colors.transparent,
        margin: margin,
        height: 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < total; i++)
              AnimatedContainer(
                decoration: BoxDecoration(
                  color: i == activeIndex ? resolvedActive : resolvedInactive,
                ),
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: i == activeIndex ? 16.0 : 4.0,
                height: 4.0,
              ),
          ],
        ),
      ),
    );
  }
}
