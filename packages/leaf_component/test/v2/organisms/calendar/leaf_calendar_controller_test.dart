import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_leaf_component/src/v2/organisms/calendar/controller/leaf_calendar_controller.dart';

void main() {
  group('LeafCalendarController', () {
    late LeafCalendarController controller;

    setUp(() {
      controller = LeafCalendarController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('goToToday emits LeafCalendarTodayEvent', () async {
      final events = <LeafCalendarEvent>[];
      controller.stream.listen(events.add);

      controller.goToToday();
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      expect(events.first, isA<LeafCalendarTodayEvent>());
    });

    test('selectDate emits LeafCalendarSelectEvent with correct date',
        () async {
      final events = <LeafCalendarEvent>[];
      controller.stream.listen(events.add);

      final target = DateTime(2024, 6, 15);
      controller.selectDate(target);
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      final event = events.first as LeafCalendarSelectEvent;
      expect(event.dateTime, target);
    });

    test('goToMonth emits LeafCalendarMonthEvent with correct date', () async {
      final events = <LeafCalendarEvent>[];
      controller.stream.listen(events.add);

      final target = DateTime(2025, 1);
      controller.goToMonth(target);
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      final event = events.first as LeafCalendarMonthEvent;
      expect(event.dateTime, target);
    });
  });
}
