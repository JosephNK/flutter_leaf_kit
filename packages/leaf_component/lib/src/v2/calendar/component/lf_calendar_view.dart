library lf_calendar_view;

import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_data/leaf_data.dart';

part 'helper/date_extension.dart';
part 'provider/lf_calendar_provider.dart';
part 'widget/lf_calendar_page_cell.dart';
part 'widget/lf_calendar_page_view.dart';

typedef LFCalendarViewOnMonthChanged = void Function(
  DateTime startDateInMonth,
  DateTime endDateInMonth,
);
typedef LFCalendarViewOnDateSelected = void Function(
  List<DateTime> dates,
);

typedef LFCalendarHeaderBuilder = Widget Function(
  BuildContext context,
);

class LFCalendarView<T> extends StatefulWidget {
  final DateTime defaultDate;
  final DateTime minDate;
  final DateTime maxDate;
  final List<T> items;
  final LFCalendarHeaderBuilder? headerBuilder;
  final LFCalendarViewOnMonthChanged? onMonthChanged;
  final LFCalendarViewOnDateSelected? onDateSelected;

  const LFCalendarView({
    Key? key,
    required this.defaultDate,
    required this.minDate,
    required this.maxDate,
    required this.items,
    this.headerBuilder,
    this.onMonthChanged,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<LFCalendarView> createState() => _LFCalendarViewState();
}

class _LFCalendarViewState extends State<LFCalendarView> {
  late PageController _pageController;

  List<DateTime> _dateTimes = [];

  int _pageNum = 0;
  double _pageHeight = 0.0;
  DateTime _currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    final minDate = widget.minDate;
    final maxDate = widget.maxDate;

    int maxDays(int cnt) {
      return DateTime(minDate.year, minDate.month + cnt)
          .difference(DateTime(maxDate.year, maxDate.month))
          .inDays;
    }

    for (var cnt = 0; 0 >= maxDays(cnt); cnt++) {
      _dateTimes.add(DateTime(minDate.year, minDate.month + cnt, 1));
    }

    _currentDateTime = widget.defaultDate;

    _pageNum = (_currentDateTime.year - minDate.year) * 12 +
        _currentDateTime.month -
        minDate.month;

    _pageController = PageController(
      initialPage: _pageNum,
      keepPage: true,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageHeight == 0.0) {
      return LFCalendarPageView(
        firstDateTime: DateTime.now(),
        onChangeSized: (size) {
          setState(() {
            _pageHeight = size.height;
          });
        },
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LFCalendarProvider(
            dateTime: _currentDateTime,
            onCellTapped: (dates) {
              widget.onDateSelected?.call(dates);
            },
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LFCalendarProvider>(
                builder: (context, provider, child) {
                  final currentDateTime = provider.currentDateTime;
                  final selectedDateTimes = provider.selectedDateTimes.toList();

                  return widget.headerBuilder?.call(context) ?? Container();
                },
              ),
              SizedBox(
                height: _pageHeight,
                child: Consumer<LFCalendarProvider>(
                  builder: (context, provider, child) {
                    final currentDateTime = provider.currentDateTime;
                    final selectedDateTimes =
                        provider.selectedDateTimes.toList();

                    return PageView.builder(
                      controller: _pageController,
                      itemCount: _dateTimes.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final dateTime = _dateTimes[index];

                        return LFCalendarPageView(
                          firstDateTime: dateTime,
                          onChangeSized: (size) {
                            setState(() {
                              _pageHeight = size.height;
                            });
                          },
                        );
                      },
                      onPageChanged: (index) {
                        final dateTime = _dateTimes[index];
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
