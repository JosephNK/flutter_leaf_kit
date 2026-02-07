import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_leaf_component/src/v2/component/calendar/controller/lf_calendar_controller_v2.dart';

void main() {
  group('LFCalendarControllerV2', () {
    late LFCalendarControllerV2 controller;

    setUp(() {
      controller = LFCalendarControllerV2();
    });

    tearDown(() {
      controller.dispose();
    });

    test('goToToday emits LFCalendarTodayEventV2', () async {
      final events = <LFCalendarEventV2>[];
      controller.stream.listen(events.add);

      controller.goToToday();
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      expect(events.first, isA<LFCalendarTodayEventV2>());
    });

    test('selectDate emits LFCalendarSelectEventV2 with correct date',
        () async {
      final events = <LFCalendarEventV2>[];
      controller.stream.listen(events.add);

      final target = DateTime(2024, 6, 15);
      controller.selectDate(target);
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      final event = events.first as LFCalendarSelectEventV2;
      expect(event.dateTime, target);
    });

    test('goToMonth emits LFCalendarMonthEventV2 with correct date', () async {
      final events = <LFCalendarEventV2>[];
      controller.stream.listen(events.add);

      final target = DateTime(2025, 1);
      controller.goToMonth(target);
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      final event = events.first as LFCalendarMonthEventV2;
      expect(event.dateTime, target);
    });
  });
}
