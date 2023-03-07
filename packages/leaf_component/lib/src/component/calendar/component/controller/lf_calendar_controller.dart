part of lf_calendar_view;

abstract class LFCalendarControllerEvent {}

class LFCalendarControllerTodayEvent extends LFCalendarControllerEvent {
  LFCalendarControllerTodayEvent();
}

class LFCalendarControllerSelectedEvent extends LFCalendarControllerEvent {
  final DateTime dateTime;

  LFCalendarControllerSelectedEvent({required this.dateTime});
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

  void addEvent(LFCalendarControllerEvent value) {
    streamController?.sink.add(value);
  }

  void addTodayEvent() {
    addEvent(LFCalendarControllerTodayEvent());
  }

  void addSelectedEvent(DateTime dateTime) {
    addEvent(LFCalendarControllerSelectedEvent(dateTime: dateTime));
  }

  void addMonthSelectedEvent(DateTime dateTime) {
    addEvent(LFCalendarControllerMonthSelectedEvent(dateTime: dateTime));
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
