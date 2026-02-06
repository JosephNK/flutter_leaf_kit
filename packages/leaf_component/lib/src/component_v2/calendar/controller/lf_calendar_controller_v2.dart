import 'dart:async';

import 'package:flutter/foundation.dart';

/// Events dispatched through [LFCalendarControllerV2].
@immutable
sealed class LFCalendarEventV2 {
  const LFCalendarEventV2();
}

/// Request the calendar to jump to today.
class LFCalendarTodayEventV2 extends LFCalendarEventV2 {
  const LFCalendarTodayEventV2();
}

/// Request the calendar to select a specific date.
class LFCalendarSelectEventV2 extends LFCalendarEventV2 {
  final DateTime dateTime;

  const LFCalendarSelectEventV2({required this.dateTime});
}

/// Request the calendar to jump to a specific month.
class LFCalendarMonthEventV2 extends LFCalendarEventV2 {
  final DateTime dateTime;

  const LFCalendarMonthEventV2({required this.dateTime});
}

/// External controller for [LFCalendarViewV2].
///
/// Allows programmatic navigation (jump to today, select date, switch month).
class LFCalendarControllerV2 {
  final _controller = StreamController<LFCalendarEventV2>.broadcast();

  /// The event stream the calendar view listens to.
  Stream<LFCalendarEventV2> get stream => _controller.stream;

  /// Jump the calendar to today and select today's date.
  void goToToday() {
    _controller.add(const LFCalendarTodayEventV2());
  }

  /// Select [dateTime] and navigate to its month page.
  void selectDate(DateTime dateTime) {
    _controller.add(LFCalendarSelectEventV2(dateTime: dateTime));
  }

  /// Navigate to the month containing [dateTime].
  void goToMonth(DateTime dateTime) {
    _controller.add(LFCalendarMonthEventV2(dateTime: dateTime));
  }

  /// Release resources.  Call from the host widget's [dispose].
  void dispose() {
    _controller.close();
  }
}
