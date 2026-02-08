import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../date/extension_calendar.dart';

/// Month header with prev/next navigation and a year.month label.
///
/// Style resolution:
///   1. Explicit parameters
///   2. [LeafCalendarThemeData] from the nearest [LeafTheme]
///   3. Global tokens
@immutable
class LeafCalendarMonthView extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback? onTitleTap;

  /// Override the title text style.
  final TextStyle? titleTextStyle;

  const LeafCalendarMonthView({
    super.key,
    required this.dateTime,
    this.onPrev,
    this.onNext,
    this.onTitleTap,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;

    final label = dateTime.toYearMonthString();

    final arrowBgColor = colors.onSurface.withValues(alpha: 0.08);
    final arrowIconColor = colors.onSurface;

    final resolvedTitleStyle =
        titleTextStyle ??
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
          color: colors.onSurface,
        );

    return Semantics(
      label: 'Calendar month: $label',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (onPrev != null)
                _ArrowButton(
                  icon: Icons.arrow_back_ios_new,
                  bgColor: arrowBgColor,
                  iconColor: arrowIconColor,
                  onTap: onPrev!,
                ),
              GestureDetector(
                onTap: onTitleTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    label,
                    style: resolvedTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (onNext != null)
                _ArrowButton(
                  icon: Icons.arrow_forward_ios,
                  bgColor: arrowBgColor,
                  iconColor: arrowIconColor,
                  onTap: onNext!,
                ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: Center(child: Icon(icon, size: 14.0, color: iconColor)),
      ),
    );
  }
}
