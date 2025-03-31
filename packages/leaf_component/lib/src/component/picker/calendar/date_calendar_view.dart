import 'package:flutter/material.dart';
import 'package:flutter_leaf_datetime/leaf_datetime.dart';

import 'date_calendar_cell.dart';
import 'date_calendar_header_view.dart';

class DateCalendarView extends StatefulWidget {
  final DateTime selectedDateTime;
  final ValueChanged<DateTime>? onDateTimeChanged;

  const DateCalendarView({
    super.key,
    required this.selectedDateTime,
    this.onDateTimeChanged,
  });

  @override
  State<DateCalendarView> createState() => _DateCalendarViewState();
}

class _DateCalendarViewState extends State<DateCalendarView> {
  final GlobalKey _gridKey = GlobalKey();
  late DateTime _selectedDateTime;
  List<DateTime> _dateTimes = [];

  @override
  void initState() {
    super.initState();

    _selectedDateTime = widget.selectedDateTime;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setDateTimes(_selectedDateTime);
    });
  }

  @override
  void didUpdateWidget(covariant DateCalendarView oldWidget) {
    if (oldWidget.selectedDateTime != widget.selectedDateTime) {
      setState(() {
        _selectedDateTime = widget.selectedDateTime;
        _setDateTimes(_selectedDateTime);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateCalendarHeaderView(
          date: _selectedDateTime,
          onLeftTap: () {
            final dateTime = _selectedDateTime.addMonths(-1);
            widget.onDateTimeChanged?.call(dateTime);
          },
          onRightTap: () {
            final dateTime = _selectedDateTime.addMonths(1);
            widget.onDateTimeChanged?.call(dateTime);
          },
        ),
        GridView.builder(
          key: _gridKey,
          itemCount: _dateTimes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final dateTime = _dateTimes[index];
            final isDisabled = (_selectedDateTime.month != dateTime.month);

            return Material(
              type: MaterialType.transparency,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return DateCalendarCell(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    dateTime: dateTime,
                    selectedDateTime: _selectedDateTime,
                    isDisabled: isDisabled,
                    onSelected: (dateTime) {
                      widget.onDateTimeChanged?.call(dateTime);
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _setDateTimes(DateTime now) {
    _dateTimes = [];
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    int daysToSubtract = firstDayOfMonth.weekday % 7;
    final calendarStart =
        firstDayOfMonth.subtract(Duration(days: daysToSubtract));
    DateTime date = calendarStart;
    for (int week = 0; week < 6; week++) {
      // String weekRow = '';
      for (int day = 0; day < 7; day++) {
        // 현재 달의 날짜인 경우 굵게 표시
        if (date.month == now.month) {
          // weekRow += '${date.day.toString().padLeft(2)} ';
          _dateTimes.add(date);
        } else {
          // 다른 달의 날짜는 희미 하게 표시 (여기서 간단히 구분)
          // weekRow += ('${date.day.toString().padLeft(2)} ');
          _dateTimes.add(date);
        }
        date = date.add(const Duration(days: 1));
      }
      // print(weekRow);
    }
    setState(() {});
  }
}
