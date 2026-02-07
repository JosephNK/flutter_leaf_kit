import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../date/extension_calendar_v2.dart';

/// Builder for custom content below the day number inside a cell.
typedef LFCalendarCellBuilderV2 = Widget Function(
  BuildContext context,
  DateTime dateTime,
  Size size,
);

/// A single day cell inside the calendar month grid.
///
/// Style resolution:
///   1. Explicit parameters ([todayColor], [selectedColor], etc.)
///   2. [LFCalendarThemeData] from the nearest [LFTheme]
///   3. Global tokens
@immutable
class LFCalendarPageCellV2 extends StatelessWidget {
  final DateTime dateTime;
  final List<DateTime> selectedDates;
  final LFCalendarCellBuilderV2? cellBuilder;
  final int weekday;
  final bool isDisabled;
  final bool showToday;
  final TextStyle? dayTextStyle;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? holidayColor;
  final ValueChanged<DateTime>? onSelected;

  const LFCalendarPageCellV2({
    super.key,
    required this.dateTime,
    required this.selectedDates,
    this.cellBuilder,
    this.weekday = -1,
    this.isDisabled = false,
    this.showToday = true,
    this.dayTextStyle,
    this.todayColor,
    this.selectedColor,
    this.holidayColor,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final calendarTheme = theme.calendarTheme;

    final resolvedTodayColor =
        todayColor ?? calendarTheme?.todayColor ?? colors.primary;
    final resolvedSelectedColor =
        selectedColor ?? calendarTheme?.selectedColor ?? colors.secondary;
    final resolvedHolidayColor =
        holidayColor ?? calendarTheme?.holidayColor ?? colors.error;
    final resolvedDayTextStyle =
        dayTextStyle ?? calendarTheme?.dayTextStyle;

    final isToday = dateTime.isToday;
    final isSelected = onSelected != null &&
        selectedDates.any((d) => dateTime.isSameDay(d));
    final day = dateTime.day.toString();

    final dayBgColor = isToday && showToday
        ? resolvedTodayColor
        : Colors.transparent;

    final dayTextColor = weekday == 7
        ? resolvedHolidayColor
        : isToday && showToday
            ? colors.onPrimary
            : colors.onSurface;

    return Semantics(
      label: 'Day $day',
      selected: isSelected,
      enabled: !isDisabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isDisabled ? null : () => onSelected?.call(dateTime),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dayBgColor,
                        border: isSelected
                            ? Border.all(color: resolvedSelectedColor)
                            : null,
                      ),
                      child: Opacity(
                        opacity: isDisabled ? 0.3 : 1.0,
                        child: Center(
                          child: Text(
                            day,
                            style: resolvedDayTextStyle?.copyWith(
                                    color: dayTextColor) ??
                                TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: dayTextColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (_, innerConstraints) {
                        return cellBuilder?.call(
                              context,
                              dateTime,
                              Size(
                                innerConstraints.maxWidth,
                                innerConstraints.maxHeight,
                              ),
                            ) ??
                            const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
