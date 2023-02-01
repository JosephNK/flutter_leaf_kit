library lf_calendar_view;

import 'dart:collection';

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

typedef LFCalendarCellBuilder = Widget Function(
  BuildContext context,
  DateTime dateTime,
  Size size,
);

class LFCalendarView extends StatefulWidget {
  final DateTime defaultDate;
  final DateTime minDate;
  final DateTime maxDate;
  final LFCalendarCellBuilder cellBuilder;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color holidayColor;
  final double childAspectRatio;
  final List<String> weekDays;
  final String yearUnit;
  final String monthUnit;
  final ScrollPhysics? physics;
  final LFCalendarViewOnMonthChanged? onMonthChanged;
  final LFCalendarViewOnDateSelected? onDateSelected;

  const LFCalendarView({
    Key? key,
    required this.defaultDate,
    required this.minDate,
    required this.maxDate,
    required this.cellBuilder,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.holidayColor = Colors.red,
    this.childAspectRatio = 1.0,
    this.weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    this.yearUnit = '.',
    this.monthUnit = '',
    this.physics,
    this.onMonthChanged,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<LFCalendarView> createState() => _LFCalendarViewState();
}

class _LFCalendarViewState extends State<LFCalendarView> {
  late PageController _pageController;

  final List<DateTime> _pageDateTimes = [];

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
      _pageDateTimes.add(DateTime(minDate.year, minDate.month + cnt, 1));
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
    final dayTextStyle = widget.dayTextStyle;
    final todayColor = widget.todayColor;
    final holidayColor = widget.holidayColor;
    final childAspectRatio = widget.childAspectRatio;
    final weekDays = widget.weekDays;
    final yearUnit = widget.yearUnit;
    final monthUnit = widget.monthUnit;
    final physics = widget.physics;
    final cellBuilder = widget.cellBuilder;
    final onMonthChanged = widget.onMonthChanged;

    Widget buildPageView(
      BuildContext context, {
      required DateTime pageDateTime,
    }) {
      return LFCalendarPageView(
        cellBuilder: cellBuilder,
        pageDateTime: pageDateTime,
        dayTextStyle: dayTextStyle,
        todayColor: todayColor,
        holidayColor: holidayColor,
        childAspectRatio: childAspectRatio,
        onSelected: (dateTime) {
          context.read<LFCalendarProvider>().toggle(dateTime, multiple: false);
        },
        onChangeSized: (size) {
          setState(() {
            _pageHeight = size.height;
          });
        },
      );
    }

    if (_pageHeight == 0.0) {
      return buildPageView(
        context,
        pageDateTime: DateTime.now(),
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
                  final year = currentDateTime.toYear();
                  final month = currentDateTime.toMonth();

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onTapAtPrevious(
                                  context, currentDateTime, onMonthChanged);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 16.0,
                              color: Color.fromRGBO(186, 186, 186, 1),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            '$year$yearUnit $month$monthUnit',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              onTapAtNext(
                                  context, currentDateTime, onMonthChanged);
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Color.fromRGBO(186, 186, 186, 1),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < weekDays.length; i++)
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  weekDays[i],
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: (i == 0)
                                        ? holidayColor
                                        : const Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: _pageHeight,
                child: Consumer<LFCalendarProvider>(
                  builder: (context, provider, child) {
                    // final currentDateTime = provider.currentDateTime;
                    // final selectedDateTimes =
                    //     provider.selectedDateTimes.toList();

                    return PageView.builder(
                      physics: physics,
                      controller: _pageController,
                      itemCount: _pageDateTimes.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final pageDateTime = _pageDateTimes[index];

                        return buildPageView(
                          context,
                          pageDateTime: pageDateTime,
                        );
                      },
                      onPageChanged: (index) {
                        final pageDateTime = _pageDateTimes[index];

                        onPageChangedAtDateTime(
                            context, pageDateTime, onMonthChanged);
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

  ///
  /// Provider with onMonthChanged
  ///

  void onTapAtPrevious(
    BuildContext context,
    DateTime currentDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) {
    final dateTime = currentDateTime.previousMonth();

    context.read<LFCalendarProvider>().setDateTime(dateTime);

    previousPage();

    onMonthChanged?.call(
      dateTime.firstDayOfWeek(),
      dateTime.lastDayOfWeek(),
    );
  }

  void onTapAtNext(
    BuildContext context,
    DateTime currentDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) {
    final dateTime = currentDateTime.nextMonth();

    context.read<LFCalendarProvider>().setDateTime(dateTime);

    nextPage();

    onMonthChanged?.call(
      dateTime.firstDayOfWeek(),
      dateTime.lastDayOfWeek(),
    );
  }

  void onPageChangedAtDateTime(
    BuildContext context,
    DateTime pageDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) {
    context.read<LFCalendarProvider>().setDateTime(pageDateTime);

    onMonthChanged?.call(
      pageDateTime.firstDayOfWeek(),
      pageDateTime.lastDayOfWeek(),
    );
  }

  ///
  /// PageController To page
  ///

  void animatedToPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }
}
