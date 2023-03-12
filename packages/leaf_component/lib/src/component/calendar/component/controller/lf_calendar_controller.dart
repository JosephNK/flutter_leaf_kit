part of lf_calendar_view;

abstract class LFCalendarControllerEvent {}

class LFCalendarControllerTodayEvent extends LFCalendarControllerEvent {
  LFCalendarControllerTodayEvent();
}

class LFCalendarControllerSelectedEvent extends LFCalendarControllerEvent {
  final DateTime dateTime;
  final bool useSendEvent;

  LFCalendarControllerSelectedEvent(
      {required this.dateTime, this.useSendEvent = false});
}

class LFCalendarControllerMonthSelectedEvent extends LFCalendarControllerEvent {
  final DateTime dateTime;

  LFCalendarControllerMonthSelectedEvent({required this.dateTime});
}

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

class LFCalendarController with LFCalendarControllerMixIn {
  LFCalendarController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
