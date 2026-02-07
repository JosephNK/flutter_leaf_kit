import 'package:flutter/material.dart';

import '../date/extension_calendar_v2.dart';
import 'lf_calendar_page_cell_v2.dart';

/// Callback when the grid's rendered size changes.
typedef LFCalendarPageViewOnSizeChangedV2 = void Function(Size size);

/// A month grid (7 columns × 6 rows) displaying day cells for [pageDateTime].
@immutable
class LFCalendarPageViewV2 extends StatefulWidget {
  final DateTime pageDateTime;
  final List<DateTime> selectedDates;
  final LFCalendarCellBuilderV2? cellBuilder;
  final TextStyle? dayTextStyle;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? holidayColor;
  final double childAspectRatio;
  final bool showToday;
  final ValueChanged<DateTime>? onSelected;
  final LFCalendarPageViewOnSizeChangedV2? onSizeChanged;

  const LFCalendarPageViewV2({
    super.key,
    required this.pageDateTime,
    required this.selectedDates,
    this.cellBuilder,
    this.dayTextStyle,
    this.todayColor,
    this.selectedColor,
    this.holidayColor,
    this.childAspectRatio = 1.0,
    this.showToday = true,
    this.onSelected,
    this.onSizeChanged,
  });

  @override
  State<LFCalendarPageViewV2> createState() => _LFCalendarPageViewV2State();
}

class _LFCalendarPageViewV2State extends State<LFCalendarPageViewV2> {
  final GlobalKey _gridKey = GlobalKey();
  late List<DateTime> _dateTimes;

  @override
  void initState() {
    super.initState();
    _dateTimes = widget.pageDateTime.daysInMonthGrid();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportSize();
    });
  }

  void _reportSize() {
    final renderObject = _gridKey.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      widget.onSizeChanged?.call(renderObject.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: _gridKey,
      itemCount: _dateTimes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: widget.childAspectRatio,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dateTime = _dateTimes[index];
        final weekday = dateTime.weekday; // Mon=1 … Sun=7
        final isDisabled = widget.pageDateTime.month != dateTime.month;

        return LFCalendarPageCellV2(
          dateTime: dateTime,
          selectedDates: widget.selectedDates,
          cellBuilder: widget.cellBuilder,
          weekday: weekday,
          isDisabled: isDisabled,
          dayTextStyle: widget.dayTextStyle,
          todayColor: widget.todayColor,
          selectedColor: widget.selectedColor,
          holidayColor: widget.holidayColor,
          showToday: widget.showToday,
          onSelected: widget.onSelected,
        );
      },
    );
  }
}
