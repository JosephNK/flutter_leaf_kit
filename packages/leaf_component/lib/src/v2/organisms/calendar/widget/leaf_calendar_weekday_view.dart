import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// Default English short weekday labels starting from Sunday.
const _kDefaultWeekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

/// Displays a row of weekday labels (Sun–Sat) above the calendar grid.
///
/// Style resolution:
///   1. Explicit [weekdayTextStyle] / [holidayColor]
///   2. [LeafCalendarThemeData] from the nearest [LeafTheme]
///   3. Global tokens
@immutable
class LeafCalendarWeekdayView extends StatelessWidget {
  /// Custom weekday labels (length must be 7, starting from Sunday).
  final List<String>? weekdays;

  /// Text style for non-holiday weekdays.
  final TextStyle? weekdayTextStyle;

  /// Color applied to Sunday label.
  final Color? holidayColor;

  const LeafCalendarWeekdayView({
    super.key,
    this.weekdays,
    this.weekdayTextStyle,
    this.holidayColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final calendarTheme = theme.calendarTheme;

    final labels = weekdays ?? _kDefaultWeekdays;
    final resolvedHolidayColor =
        holidayColor ?? calendarTheme?.holidayColor ?? colors.error;
    final baseStyle =
        weekdayTextStyle ??
        calendarTheme?.dayTextStyle ??
        TextStyle(
          fontSize: 13.0,
          color: colors.onSurface.withValues(alpha: 0.6),
        );

    return Semantics(
      label: 'Weekday headers',
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  labels[i],
                  style: i == 0
                      ? baseStyle.copyWith(color: resolvedHolidayColor)
                      : baseStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
