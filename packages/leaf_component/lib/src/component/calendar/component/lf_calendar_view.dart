library lf_calendar_view;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_data/leaf_data.dart';

import '../../text/lf_text.dart';

part 'controller/lf_calendar_controller.dart';
part 'provider/lf_calendar_provider.dart';
part 'widget/lf_calendar_month_date_picker.dart';
part 'widget/lf_calendar_page_cell.dart';
part 'widget/lf_calendar_page_view.dart';

enum LFCalendarFormat { month }

typedef LFCalendarViewOnMonthOnTap = void Function(
  DateTime month,
);

typedef LFCalendarViewOnMonthChanged = void Function(
  DateTime month,
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
  final DateTime? defaultDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final LFCalendarCellBuilder? cellBuilder;
  final LFCalendarController? controller;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color selectedColor;
  final Color holidayColor;
  final double childAspectRatio;
  final List<String> weekDays;
  final String yearUnit;
  final String monthUnit;
  final ScrollPhysics? physics;
  final bool showToday;
  final LFCalendarViewOnMonthOnTap? onMonthOnTap;
  final LFCalendarViewOnMonthChanged? onMonthChanged;
  final LFCalendarViewOnDateSelected? onDateSelected;

  const LFCalendarView({
    Key? key,
    this.defaultDate,
    this.minDate,
    this.maxDate,
    this.cellBuilder,
    this.controller,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.selectedColor = Colors.purpleAccent,
    this.holidayColor = Colors.red,
    this.childAspectRatio = 1.0,
    this.weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    this.yearUnit = '.',
    this.monthUnit = '',
    this.physics,
    this.showToday = true,
    this.onMonthOnTap,
    this.onMonthChanged,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<LFCalendarView> createState() => _LFCalendarViewState();
}

class _LFCalendarViewState extends State<LFCalendarView> {
  late PageController _pageController;

  late DateTime _defaultDateTime;
  late DateTime _minDate;
  late DateTime _maxDate;
  late int _initialPage;
  double _pageHeight = 0.0;

  BuildContext? _providerContext;
  StreamSubscription<LFCalendarControllerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();

    final defaultDate = widget.defaultDate ?? LFDateTime.today();
    final minDate = widget.minDate ?? DateTime(1900);
    final maxDate = widget.maxDate ?? DateTime(2200);

    _defaultDateTime = defaultDate;
    _minDate = minDate;
    _maxDate = maxDate;

    final initialPage = _calculateFocusedPage(
        LFCalendarFormat.month, minDate, _defaultDateTime);

    _initialPage = initialPage;

    _pageController = PageController(
      initialPage: _initialPage,
      keepPage: true,
      viewportFraction: 1.0,
    );

    _streamSubscription = widget.controller?.streamController?.stream
        .asBroadcastStream()
        .listen((event) {
      final context = _providerContext;
      if (context != null) {
        if (event is LFCalendarControllerTodayEvent) {
          onActionAtToday(context, widget.onMonthChanged);
        }
        if (event is LFCalendarControllerSelectedEvent) {
          onActionAtSelected(context, event.dateTime, null);
        }
        if (event is LFCalendarControllerMonthSelectedEvent) {
          onActionAtMonthSelected(context, event.dateTime);
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _streamSubscription?.cancel();
    _providerContext = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayTextStyle = widget.dayTextStyle;
    final todayColor = widget.todayColor;
    final selectedColor = widget.selectedColor;
    final holidayColor = widget.holidayColor;
    final childAspectRatio = widget.childAspectRatio;
    final weekDays = widget.weekDays;
    final yearUnit = widget.yearUnit;
    final monthUnit = widget.monthUnit;
    final physics = widget.physics;
    final showToday = widget.showToday;
    final cellBuilder = widget.cellBuilder;
    final onMonthChanged = widget.onMonthChanged;

    Widget buildPageView(
      BuildContext context, {
      required DateTime pageDateTime,
      List<DateTime> selectedDateTimes = const [],
    }) {
      return LFCalendarPageView(
        pageDateTime: pageDateTime,
        selectedDateTimes: selectedDateTimes,
        cellBuilder: cellBuilder,
        dayTextStyle: dayTextStyle,
        todayColor: todayColor,
        selectedColor: selectedColor,
        holidayColor: holidayColor,
        childAspectRatio: childAspectRatio,
        showToday: showToday,
        onSelected: (dateTime) {
          onActionAtSelected(context, dateTime, null);
        },
        onChangeSized: (size) {
          setState(() {
            _pageHeight = size.height;
          });
        },
      );
    }

    if (_pageHeight == 0.0) {
      return buildPageView(context, pageDateTime: _defaultDateTime);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LFCalendarProvider(
            dateTime: _defaultDateTime,
            onCellTapped: (dates) {
              widget.onDateSelected?.call(dates);
            },
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          _providerContext = context;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LFCalendarProvider>(
                builder: (context, provider, child) {
                  final currentDateTime = provider.currentDateTime;
                  final year = currentDateTime.toYearString();
                  final month = currentDateTime.toMonthString();

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onActionAtPrevious(
                                  context, currentDateTime, onMonthChanged);
                            },
                            child: Container(
                              width: 25.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: const Color.fromRGBO(186, 186, 186, 0.3),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 14.0,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final onMonthOnTap = widget.onMonthOnTap;
                              if (onMonthOnTap != null) {
                                final date = LFDateTime.parse(currentDateTime
                                    .toDateTimeString(format: 'yyyy-MM-dd'));
                                LFCalendarMonthDatePicker.show(
                                  context,
                                  date: date,
                                  onOK: (dateTime) {
                                    onActionAtMonthSelected(context, dateTime);
                                  },
                                );
                                onMonthOnTap.call(date);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                '$year$yearUnit$month$monthUnit',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              onActionAtNext(
                                  context, currentDateTime, onMonthChanged);
                            },
                            child: Container(
                              width: 25.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: const Color.fromRGBO(186, 186, 186, 0.3),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14.0,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
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
                    final selectedDateTimes =
                        provider.selectedDateTimes.toList();

                    return PageView.builder(
                      physics: physics,
                      controller: _pageController,
                      itemCount: _getPageCount(
                          LFCalendarFormat.month, _minDate, _maxDate),
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final pageDateTime =
                            _getBaseDay(LFCalendarFormat.month, index);

                        return buildPageView(
                          context,
                          pageDateTime: pageDateTime,
                          selectedDateTimes: selectedDateTimes,
                        );
                      },
                      onPageChanged: (index) {
                        final pageDateTime =
                            _getBaseDay(LFCalendarFormat.month, index);

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

  int _calculateFocusedPage(
      LFCalendarFormat format, DateTime startDay, DateTime focusedDay) {
    switch (format) {
      case LFCalendarFormat.month:
        return _getMonthCount(startDay, focusedDay);
    }
  }

  int _getPageCount(LFCalendarFormat format, DateTime first, DateTime last) {
    switch (format) {
      case LFCalendarFormat.month:
        return _getMonthCount(first, last) + 1;
    }
  }

  int _getMonthCount(DateTime first, DateTime last) {
    final yearDif = last.year - first.year;
    final monthDif = last.month - first.month;
    return yearDif * 12 + monthDif;
  }

  DateTime _getBaseDay(LFCalendarFormat format, int pageIndex) {
    DateTime day;

    DateTime firstDay = _minDate;
    DateTime lastDay = _maxDate;

    switch (format) {
      case LFCalendarFormat.month:
        day = DateTime.utc(firstDay.year, firstDay.month + pageIndex);
        break;
    }

    if (day.isBefore(firstDay)) {
      day = firstDay;
    } else if (day.isAfter(lastDay)) {
      day = lastDay;
    }

    return day;
  }

  ///
  /// Provider with onMonthChanged
  ///

  final _pageDuration = const Duration(milliseconds: 150);

  void onActionAtSelected(
    BuildContext context,
    DateTime dateTime,
    List<DateTime>? selectedDateTimes,
  ) {
    if (selectedDateTimes == null) {
      context.read<LFCalendarProvider>().toggle(dateTime);
      return;
    }
    if (selectedDateTimes.isNotEmpty) {
      final selectedDateTime = selectedDateTimes.first;
      final year = dateTime.year.toString();
      final month = dateTime.month.toString().padLeft(2, '0');
      final day = selectedDateTime.day.toString().padLeft(2, '0');
      context
          .read<LFCalendarProvider>()
          .toggle(LFDateTime.parse('$year-$month-$day'));
    }
  }

  void onActionAtMonthSelected(
    BuildContext context,
    DateTime dateTime,
  ) async {
    final selectedDateTimes = List<DateTime>.from(
        context.read<LFCalendarProvider>().selectedDateTimes);
    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    final page =
        _calculateFocusedPage(LFCalendarFormat.month, _minDate, dateTime);

    animateToPage(page, animate: false);

    await Future.delayed(_pageDuration);

    if (!mounted) return;
    onActionAtSelected(context, dateTime, selectedDateTimes);
  }

  void onActionAtToday(
    BuildContext context,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) async {
    final dateTime = LFDateTime.today();

    final selectedDateTimes = List<DateTime>.from(
        context.read<LFCalendarProvider>().selectedDateTimes);
    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    todayPage(animate: false);

    await Future.delayed(_pageDuration);

    if (!mounted) return;
    onActionAtSelected(context, dateTime, selectedDateTimes);

    onMonthChanged?.call(
      dateTime.inMonth(),
      dateTime.firstDayOfWeek(),
      dateTime.lastDayOfWeek(),
    );
  }

  void onActionAtPrevious(
    BuildContext context,
    DateTime currentDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) async {
    final dateTime = currentDateTime.previousMonth();

    final selectedDateTimes = List<DateTime>.from(
        context.read<LFCalendarProvider>().selectedDateTimes);
    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    previousPage();

    await Future.delayed(_pageDuration);

    if (!mounted) return;
    onActionAtSelected(context, dateTime, selectedDateTimes);

    onMonthChanged?.call(
      dateTime.inMonth(),
      dateTime.firstDayOfWeek(),
      dateTime.lastDayOfWeek(),
    );
  }

  void onActionAtNext(
    BuildContext context,
    DateTime currentDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) async {
    final dateTime = currentDateTime.nextMonth();

    final selectedDateTimes = List<DateTime>.from(
        context.read<LFCalendarProvider>().selectedDateTimes);
    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    nextPage();

    await Future.delayed(_pageDuration);

    if (!mounted) return;
    onActionAtSelected(context, dateTime, selectedDateTimes);

    onMonthChanged?.call(
      dateTime.inMonth(),
      dateTime.firstDayOfWeek(),
      dateTime.lastDayOfWeek(),
    );
  }

  void onPageChangedAtDateTime(
    BuildContext context,
    DateTime pageDateTime,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) async {
    final selectedDateTimes = List<DateTime>.from(
        context.read<LFCalendarProvider>().selectedDateTimes);
    context.read<LFCalendarProvider>().setDateTime(pageDateTime);
    context.read<LFCalendarProvider>().removeAll();

    // await Future.delayed(_pageDuration);

    if (!mounted) return;
    onActionAtSelected(context, pageDateTime, selectedDateTimes);

    onMonthChanged?.call(
      pageDateTime.inMonth(),
      pageDateTime.firstDayOfWeek(),
      pageDateTime.lastDayOfWeek(),
    );
  }

  ///
  /// PageController To page
  ///

  void animateToPage(int page, {bool animate = true}) {
    if (animate) {
      _pageController.animateToPage(page,
          duration: _pageDuration, curve: Curves.easeIn);
    } else {
      _pageController.jumpToPage(page);
    }
  }

  void todayPage({bool animate = true}) {
    final page = _initialPage;
    animateToPage(page, animate: animate);
  }

  void previousPage({bool animate = true}) {
    final page = _pageController.page!.toInt() - 1;
    animateToPage(page, animate: animate);
  }

  void nextPage({bool animate = true}) {
    final page = _pageController.page!.toInt() + 1;
    animateToPage(page, animate: animate);
  }
}
