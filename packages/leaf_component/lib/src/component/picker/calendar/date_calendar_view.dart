import 'package:flutter/material.dart';
import 'package:flutter_leaf_datetime/leaf_datetime.dart';

import 'date_calendar_cell.dart';
import 'date_calendar_header_view.dart';

class DateCalendarView extends StatefulWidget {
  const DateCalendarView({super.key});

  @override
  State<DateCalendarView> createState() => _DateCalendarViewState();
}

class _DateCalendarViewState extends State<DateCalendarView> {
  final GlobalKey _gridKey = GlobalKey();
  List<DateTime> _dateTimes = [];
  DateTime pageDateTime = LFDate.now().dateTime;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setDateTimes(pageDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateCalendarHeaderView(
          date: pageDateTime,
          onLeftTap: () {
            //
          },
          onRightTap: () {
            //
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
            final isDisabled = (pageDateTime.month != dateTime.month);

            return Material(
              type: MaterialType.transparency,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isDisabled) return;
                  // onSelected?.call(dateTime);
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return DateCalendarCell(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      dateTime: dateTime,
                      isDisabled: isDisabled,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void setDateTimes(DateTime now) {
    _dateTimes = [];
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    int daysToSubtract = firstDayOfMonth.weekday % 7;
    final calendarStart =
        firstDayOfMonth.subtract(Duration(days: daysToSubtract));
    DateTime date = calendarStart;
    for (int week = 0; week < 6; week++) {
      String weekRow = '';
      for (int day = 0; day < 7; day++) {
        // 현재 달의 날짜인 경우에는 굵게 표시
        if (date.month == now.month) {
          weekRow += '${date.day.toString().padLeft(2)} ';
          _dateTimes.add(date);
        } else {
          // 다른 달의 날짜는 희미하게 표시 (여기서는 간단히 구분)
          weekRow += ('${date.day.toString().padLeft(2)} ');
          _dateTimes.add(date);
        }
        date = date.add(const Duration(days: 1));
      }
      print(weekRow);
    }
    setState(() {});
  }

  int _getMonthCount(DateTime first, DateTime last) {
    final yearDif = last.year - first.year;
    final monthDif = last.month - first.month;
    return yearDif * 12 + monthDif;
  }
}
