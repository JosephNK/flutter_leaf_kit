import 'dart:async';

import 'package:flutter/foundation.dart';

/// Events dispatched through [LeafCalendarController].
@immutable
sealed class LeafCalendarEvent {
  const LeafCalendarEvent();
}

/// Request the calendar to jump to today.
class LeafCalendarTodayEvent extends LeafCalendarEvent {
  const LeafCalendarTodayEvent();
}

/// Request the calendar to select a specific date.
class LeafCalendarSelectEvent extends LeafCalendarEvent {
  final DateTime dateTime;

  const LeafCalendarSelectEvent({required this.dateTime});
}

/// Request the calendar to jump to a specific month.
class LeafCalendarMonthEvent extends LeafCalendarEvent {
  final DateTime dateTime;

  const LeafCalendarMonthEvent({required this.dateTime});
}

/// External controller for [LeafCalendarView].
///
/// Allows programmatic navigation (jump to today, select date, switch month).
class LeafCalendarController {
  final _controller = StreamController<LeafCalendarEvent>.broadcast();

  /// The event stream the calendar view listens to.
  Stream<LeafCalendarEvent> get stream => _controller.stream;

  /// Jump the calendar to today and select today's date.
  void goToToday() {
    _controller.add(const LeafCalendarTodayEvent());
  }

  /// Select [dateTime] and navigate to its month page.
  void selectDate(DateTime dateTime) {
    _controller.add(LeafCalendarSelectEvent(dateTime: dateTime));
  }

  /// Navigate to the month containing [dateTime].
  void goToMonth(DateTime dateTime) {
    _controller.add(LeafCalendarMonthEvent(dateTime: dateTime));
  }

  /// Release resources.  Call from the host widget's [dispose].
  void dispose() {
    _controller.close();
  }
}
