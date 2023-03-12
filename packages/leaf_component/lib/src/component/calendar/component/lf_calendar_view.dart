library lf_calendar_view;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_data/leaf_data.dart';

import '../../text/lf_text.dart';

part 'controller/lf_calendar_controller.dart';
part 'provider/lf_calendar_provider.dart';
part 'widget/lf_calendar_month_date_picker.dart';
part 'widget/lf_calendar_month_view.dart';
part 'widget/lf_calendar_page_cell.dart';
part 'widget/lf_calendar_page_view.dart';
part 'widget/lf_calendar_weekday_view.dart';

enum LFCalendarFormat { month }

typedef LFCalendarViewOnMonthOnTap = void Function(
  DateTime month,
);

typedef LFCalendarViewOnMonthChanged = void Function(
  DateTime startDateInMonth,
  DateTime endDateInMonth,
  DateTime monthDate,
  DateTime? selectedDate,
);

typedef LFCalendarViewOnDateSelected = void Function(
  DateTime? selectedDate,
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
  final String okText;
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
    this.okText = 'OK',
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
  late int _todayPage;
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
    final todayPage = _calculateFocusedPage(
        LFCalendarFormat.month, minDate, LFDateTime.today());

    _initialPage = initialPage;
    _todayPage = todayPage;

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
          onActionAtToday(context);
        }
        if (event is LFCalendarControllerSelectedEvent) {
          onActionAtSelected(context, event.dateTime, null,
              useSendEvent: event.useSendEvent);
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
    final physics = widget.physics;
    final showToday = widget.showToday;
    final cellBuilder = widget.cellBuilder;
    final onDateSelected = widget.onDateSelected;
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
        onSelected: (onDateSelected == null)
            ? null
            : (dateTime) {
                onActionAtSelected(context, dateTime, null, useSendEvent: true);
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
              // Send Event CallBack
              final selectDate = dates.isNotEmpty ? dates.first : null;
              onDateSelected?.call(selectDate);
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

                  return LFCalendarMonthView(
                    dateTime: currentDateTime,
                    minDate: _minDate,
                    maxDate: _maxDate,
                    pickerActiveColor: widget.selectedColor,
                    pickerOKText: widget.okText,
                    onPrev: (onMonthChanged == null)
                        ? null
                        : () {
                            onActionAtPrevious(context, currentDateTime);
                          },
                    onNext: (onMonthChanged == null)
                        ? null
                        : () {
                            onActionAtNext(context, currentDateTime);
                          },
                    onPickerSelectTap: (widget.onMonthOnTap == null)
                        ? null
                        : (dateTime) {
                            onActionAtMonthSelected(context, dateTime);
                            widget.onMonthOnTap?.call(dateTime);
                          },
                  );
                },
              ),
              LFCalendarWeekDayView(
                holidayColor: holidayColor,
              ),
              SizedBox(
                height: _pageHeight,
                child: Consumer<LFCalendarProvider>(
                  builder: (context, provider, child) {
                    final selectedDateTimes =
                        provider.selectedDateTimes.toList();

                    return PageView.builder(
                      physics: (onMonthChanged == null)
                          ? const NeverScrollableScrollPhysics()
                          : physics,
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
    List<DateTime>? selectedDateTimes, {
    bool useSendEvent = false,
  }) {
    final page =
        _calculateFocusedPage(LFCalendarFormat.month, _minDate, dateTime);

    if (page != (_pageController.page?.toInt() ?? 0)) {
      animateToPage(page, animate: false);
    }

    final selectedDate =
        _makeSelectingDateTime(monthDateTime: dateTime, dayDateTime: null);

    // [selectedDate] 날짜로 선택 효과
    // useSendEvent 값에 의한 onDateSelected 함수 호출 여부 (default: 호출 안함)
    context
        .read<LFCalendarProvider>()
        .select(selectedDate, useSendEvent: useSendEvent);
  }

  void onActionAtMonthSelected(
    BuildContext context,
    DateTime dateTime,
  ) async {
    final page =
        _calculateFocusedPage(LFCalendarFormat.month, _minDate, dateTime);

    animateToPage(page, animate: false); // 이후 onPageChangedAtDateTime 함수 호출
  }

  void onActionAtToday(
    BuildContext context,
  ) async {
    todayPage(animate: false); // 이후 onPageChangedAtDateTime 함수 호출

    // 페이지 전환 후 [오늘] 날짜로 선택 효과 & onDateSelected 함수 호출
    context
        .read<LFCalendarProvider>()
        .select(LFDateTime.today(), useSendEvent: true);
  }

  void onActionAtPrevious(
    BuildContext context,
    DateTime currentDateTime, {
    bool animate = true,
  }) async {
    previousPage(animate: animate); // 이후 onPageChangedAtDateTime 함수 호출
  }

  void onActionAtNext(
    BuildContext context,
    DateTime currentDateTime, {
    bool animate = true,
  }) async {
    nextPage(animate: animate); // 이후 onPageChangedAtDateTime 함수 호출
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

    final selectedDate = _makeSelectingDateTime(
        monthDateTime: pageDateTime, dayDateTime: selectedDateTimes.first);

    if (kDebugMode) {
      print(
        '[LFCalendarView onPageChangedAtDateTime] p: $pageDateTime | s: $selectedDate',
      );
    }

    // 페이지 전환 후 [selectedDate] 날짜로 선택 효과 & onDateSelected 함수 호출 하지 않음
    context
        .read<LFCalendarProvider>()
        .select(selectedDate, useSendEvent: false);

    onMonthChanged?.call(
      pageDateTime.firstDayOfWeek(),
      pageDateTime.lastDayOfWeek(),
      pageDateTime.inMonth(),
      selectedDate,
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
    final page = _todayPage;
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

  ///
  /// PageController Helper
  ///

  DateTime _makeSelectingDateTime(
      {required DateTime monthDateTime, required DateTime? dayDateTime}) {
    final year = monthDateTime.year.toString();
    final month = monthDateTime.month.toString().padLeft(2, '0');
    final day = (dayDateTime == null)
        ? monthDateTime.day.toString().padLeft(2, '0')
        : dayDateTime.day.toString().padLeft(2, '0');
    return LFDateTime.parse('$year-$month-$day');
  }
}
