library lf_calendar_view;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_data/leaf_data.dart';

part 'controller/lf_calendar_controller.dart';
part 'provider/lf_calendar_provider.dart';
part 'widget/lf_calendar_page_cell.dart';
part 'widget/lf_calendar_page_view.dart';

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
  final DateTime defaultDate;
  final DateTime minDate;
  final DateTime maxDate;
  final LFCalendarCellBuilder cellBuilder;
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
  final LFCalendarViewOnMonthChanged? onMonthChanged;
  final LFCalendarViewOnDateSelected? onDateSelected;

  const LFCalendarView({
    Key? key,
    required this.defaultDate,
    required this.minDate,
    required this.maxDate,
    required this.cellBuilder,
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
    this.onMonthChanged,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<LFCalendarView> createState() => _LFCalendarViewState();
}

class _LFCalendarViewState extends State<LFCalendarView> {
  late PageController _pageController;

  final List<DateTime> _pageDateTimes = [];

  late int _initialPage;
  int _pageNum = 0;
  double _pageHeight = 0.0;
  DateTime _defaultDateTime = LFDateTime.today();

  BuildContext? _providerContext;
  StreamSubscription<LFCalendarControllerEvent>? _streamSubscription;

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

    _defaultDateTime = widget.defaultDate;

    _pageNum = (_defaultDateTime.year - minDate.year) * 12 +
        _defaultDateTime.month -
        minDate.month;

    _initialPage = _pageNum;

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
          onActionAtSelected(context, event.dateTime);
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
    final cellBuilder = widget.cellBuilder;
    final onMonthChanged = widget.onMonthChanged;

    Widget buildPageView(
      BuildContext context, {
      required DateTime pageDateTime,
      required List<DateTime> selectedDateTimes,
    }) {
      return LFCalendarPageView(
        cellBuilder: cellBuilder,
        pageDateTime: pageDateTime,
        selectedDateTimes: selectedDateTimes,
        dayTextStyle: dayTextStyle,
        todayColor: todayColor,
        selectedColor: selectedColor,
        holidayColor: holidayColor,
        childAspectRatio: childAspectRatio,
        onSelected: (dateTime) {
          onActionAtSelected(context, dateTime);
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
        pageDateTime: LFDateTime.today(),
        selectedDateTimes: const [],
      );
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
                          Padding(
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
                      itemCount: _pageDateTimes.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final pageDateTime = _pageDateTimes[index];

                        return buildPageView(
                          context,
                          pageDateTime: pageDateTime,
                          selectedDateTimes: selectedDateTimes,
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

  final _duration = const Duration(milliseconds: 150);

  void onActionAtSelected(
    BuildContext context,
    DateTime dateTime, {
    bool multiple = false,
  }) {
    context.read<LFCalendarProvider>().toggle(dateTime, multiple: multiple);
  }

  void onActionAtToday(
    BuildContext context,
    LFCalendarViewOnMonthChanged? onMonthChanged,
  ) async {
    final dateTime = LFDateTime.today();

    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    todayPage();

    await Future.delayed(_duration);

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

    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    previousPage();

    await Future.delayed(_duration);

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

    context.read<LFCalendarProvider>().setDateTime(dateTime);
    context.read<LFCalendarProvider>().removeAll();

    nextPage();

    await Future.delayed(_duration);

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
    context.read<LFCalendarProvider>().setDateTime(pageDateTime);
    context.read<LFCalendarProvider>().removeAll();

    // await Future.delayed(_duration);

    onMonthChanged?.call(
      pageDateTime.inMonth(),
      pageDateTime.firstDayOfWeek(),
      pageDateTime.lastDayOfWeek(),
    );
  }

  ///
  /// PageController To page
  ///

  void animatedToPage(int page) {
    _pageController.animateToPage(page,
        duration: _duration, curve: Curves.easeIn);
  }

  void todayPage() {
    _pageController.animateToPage(_initialPage,
        duration: _duration, curve: Curves.easeIn);
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: _duration, curve: Curves.easeIn);
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: _duration, curve: Curves.easeIn);
  }
}
