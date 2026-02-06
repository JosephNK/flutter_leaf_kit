part of '../lf_calendar_view.dart';

@Deprecated('Use LFCalendarViewV2 instead')
abstract class LFCalendarControllerEvent {}

@Deprecated('Use LFCalendarViewV2 instead')
class LFCalendarControllerTodayEvent extends LFCalendarControllerEvent {
  LFCalendarControllerTodayEvent();
}

@Deprecated('Use LFCalendarViewV2 instead')
class LFCalendarControllerSelectedEvent extends LFCalendarControllerEvent {
  final DateTime dateTime;
  final bool useSendEvent;

  LFCalendarControllerSelectedEvent(
      {required this.dateTime, this.useSendEvent = false});
}

@Deprecated('Use LFCalendarViewV2 instead')
class LFCalendarControllerMonthSelectedEvent extends LFCalendarControllerEvent {
  final DateTime dateTime;

  LFCalendarControllerMonthSelectedEvent({required this.dateTime});
}

@Deprecated('Use LFCalendarViewV2 instead')
mixin LFCalendarControllerMixIn {
  late StreamController<LFCalendarControllerEvent>? streamController;

  void init() {
    streamController = StreamController<LFCalendarControllerEvent>.broadcast();
  }

  void tearDown() {
    streamController?.close();
  }

  void fireTodayEvent() {
    _addEvent(LFCalendarControllerTodayEvent());
  }

  void fireSelectedEvent(DateTime dateTime, {bool useSendEvent = false}) {
    _addEvent(LFCalendarControllerSelectedEvent(
        dateTime: dateTime, useSendEvent: useSendEvent));
  }

  void fireMonthSelectedEvent(DateTime dateTime) {
    _addEvent(LFCalendarControllerMonthSelectedEvent(dateTime: dateTime));
  }

  void _addEvent(LFCalendarControllerEvent value) {
    streamController?.sink.add(value);
  }
}

@Deprecated('Use LFCalendarViewV2 instead')
class LFCalendarController with LFCalendarControllerMixIn {
  LFCalendarController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
