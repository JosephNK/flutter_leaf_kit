import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../controller/leaf_calendar_controller.dart';
import 'leaf_calendar_month_view.dart';
import 'leaf_calendar_page_cell.dart';
import 'leaf_calendar_page_view.dart';
import 'leaf_calendar_weekday_view.dart';

/// Callback when the displayed month changes.
typedef LeafCalendarViewOnMonthChanged =
    void Function(DateTime monthDate, DateTime? selectedDate);

/// Callback when a date is selected.
typedef LeafCalendarViewOnDateSelected = void Function(DateTime? selectedDate);

/// A full month-based calendar view with navigation and date selection.
///
/// Features:
/// - Previous / next month navigation via arrows or swiping
/// - Date selection with visual feedback
/// - External control via [LeafCalendarController]
/// - Custom cell builder for per-day content
///
/// Style resolution follows the 3-level cascade:
///   1. Explicit widget parameters
///   2. [LeafCalendarThemeData] from the nearest [LeafTheme]
///   3. Global design tokens
class LeafCalendarView extends StatefulWidget {
  /// Initially displayed (and optionally selected) date.
  final DateTime? defaultDate;

  /// Earliest navigable month.  Defaults to January 1900.
  final DateTime? minDate;

  /// Latest navigable month.  Defaults to December 2200.
  final DateTime? maxDate;

  /// Optional external controller.
  final LeafCalendarController? controller;

  /// Builder for custom content below each day number.
  final LeafCalendarCellBuilder? cellBuilder;

  /// Custom weekday labels (length 7, starting Sunday).
  final List<String>? weekdays;

  // --- style overrides ---
  final TextStyle? dayTextStyle;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? holidayColor;
  final double childAspectRatio;
  final bool showToday;

  /// Page-swipe physics.  `null` for default.
  final ScrollPhysics? physics;

  // --- callbacks ---
  final LeafCalendarViewOnMonthChanged? onMonthChanged;
  final LeafCalendarViewOnDateSelected? onDateSelected;
  final VoidCallback? onTitleTap;

  const LeafCalendarView({
    super.key,
    this.defaultDate,
    this.minDate,
    this.maxDate,
    this.controller,
    this.cellBuilder,
    this.weekdays,
    this.dayTextStyle,
    this.todayColor,
    this.selectedColor,
    this.holidayColor,
    this.childAspectRatio = 1.0,
    this.showToday = true,
    this.physics,
    this.onMonthChanged,
    this.onDateSelected,
    this.onTitleTap,
  });

  @override
  State<LeafCalendarView> createState() => _LeafCalendarViewState();
}

class _LeafCalendarViewState extends State<LeafCalendarView> {
  late PageController _pageController;
  late DateTime _minDate;
  late DateTime _maxDate;
  late int _initialPage;

  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;
  double _pageHeight = 0.0;

  StreamSubscription<LeafCalendarEvent>? _subscription;

  // --- lifecycle ---

  @override
  void initState() {
    super.initState();

    final defaultDate = widget.defaultDate ?? DateTime.now();
    _minDate = widget.minDate ?? DateTime(1900);
    _maxDate = widget.maxDate ?? DateTime(2200);

    _currentMonth = DateTime(defaultDate.year, defaultDate.month);
    _selectedDate = defaultDate;

    _initialPage = _monthsBetween(_minDate, _currentMonth);
    _pageController = PageController(initialPage: _initialPage);

    _subscription = widget.controller?.stream.listen(_handleControllerEvent);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  // --- controller events ---

  void _handleControllerEvent(LeafCalendarEvent event) {
    switch (event) {
      case LeafCalendarTodayEvent():
        _jumpToDate(DateTime.now(), select: true);
      case LeafCalendarSelectEvent(:final dateTime):
        _jumpToDate(dateTime, select: true);
      case LeafCalendarMonthEvent(:final dateTime):
        _jumpToDate(dateTime, select: false);
    }
  }

  void _jumpToDate(DateTime dateTime, {required bool select}) {
    final page = _monthsBetween(_minDate, dateTime);
    _pageController.jumpToPage(page);

    setState(() {
      _currentMonth = DateTime(dateTime.year, dateTime.month);
      if (select) {
        _selectedDate = dateTime;
        widget.onDateSelected?.call(dateTime);
      }
    });
  }

  // --- page helpers ---

  int _monthsBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + (to.month - from.month);
  }

  int get _pageCount => _monthsBetween(_minDate, _maxDate) + 1;

  DateTime _monthForPage(int pageIndex) {
    return DateTime(_minDate.year, _minDate.month + pageIndex);
  }

  // --- navigation ---

  void _goToPrevious() {
    final currentPage = _pageController.page?.round() ?? _initialPage;
    if (currentPage > 0) {
      _pageController.animateToPage(
        currentPage - 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToNext() {
    final currentPage = _pageController.page?.round() ?? _initialPage;
    if (currentPage < _pageCount - 1) {
      _pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    }
  }

  void _onPageChanged(int index) {
    final month = _monthForPage(index);
    setState(() {
      _currentMonth = month;
    });

    // Keep the previously selected day if it falls in the new month;
    // otherwise report the 1st of the new month.
    DateTime? adjusted;
    if (_selectedDate != null &&
        _selectedDate!.year == month.year &&
        _selectedDate!.month == month.month) {
      adjusted = _selectedDate;
    }

    widget.onMonthChanged?.call(month, adjusted);
  }

  void _onDateTapped(DateTime dateTime) {
    setState(() {
      _selectedDate = dateTime;
    });
    widget.onDateSelected?.call(dateTime);
  }

  // --- build ---

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final calendarTheme = theme.calendarTheme;

    final resolvedTodayColor = widget.todayColor ?? calendarTheme?.todayColor;
    final resolvedSelectedColor =
        widget.selectedColor ?? calendarTheme?.selectedColor;
    final resolvedHolidayColor =
        widget.holidayColor ?? calendarTheme?.holidayColor;
    final resolvedDayTextStyle =
        widget.dayTextStyle ?? calendarTheme?.dayTextStyle;

    Widget buildPageGrid(DateTime pageDateTime) {
      return LeafCalendarPageView(
        pageDateTime: pageDateTime,
        selectedDates: _selectedDate != null ? [_selectedDate!] : const [],
        cellBuilder: widget.cellBuilder,
        dayTextStyle: resolvedDayTextStyle,
        todayColor: resolvedTodayColor,
        selectedColor: resolvedSelectedColor,
        holidayColor: resolvedHolidayColor,
        childAspectRatio: widget.childAspectRatio,
        showToday: widget.showToday,
        onSelected: widget.onDateSelected != null ? _onDateTapped : null,
        onSizeChanged: (size) {
          if (size.height != _pageHeight) {
            setState(() {
              _pageHeight = size.height;
            });
          }
        },
      );
    }

    // First render: measure grid height with default month.
    if (_pageHeight == 0.0) {
      return buildPageGrid(_currentMonth);
    }

    return Semantics(
      label: 'Calendar',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeafCalendarMonthView(
            dateTime: _currentMonth,
            onPrev: widget.onMonthChanged != null ? _goToPrevious : null,
            onNext: widget.onMonthChanged != null ? _goToNext : null,
            onTitleTap: widget.onTitleTap,
          ),
          LeafCalendarWeekdayView(
            weekdays: widget.weekdays,
            holidayColor: resolvedHolidayColor,
          ),
          SizedBox(
            height: _pageHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pageCount,
              physics: widget.onMonthChanged != null
                  ? widget.physics
                  : const NeverScrollableScrollPhysics(),
              onPageChanged: _onPageChanged,
              itemBuilder: (_, index) {
                return buildPageGrid(_monthForPage(index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
