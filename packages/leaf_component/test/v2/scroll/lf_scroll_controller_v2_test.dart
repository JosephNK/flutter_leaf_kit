import 'package:flutter_leaf_component/src/component_v2/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFScrollControllerV2', () {
    late LFScrollControllerV2 controller;

    setUp(() {
      controller = LFScrollControllerV2();
    });

    tearDown(() {
      controller.dispose();
    });

    test('emits scrollToTop event', () {
      expectLater(
        controller.stream,
        emits(
          isA<LFScrollControllerEventV2>().having(
            (e) => e.type,
            'type',
            LFScrollControllerEventTypeV2.scrollToTop,
          ),
        ),
      );
      controller.scrollToTop(animated: true);
    });

    test('emits scrollToBottom event', () {
      expectLater(
        controller.stream,
        emits(
          isA<LFScrollControllerEventV2>().having(
            (e) => e.type,
            'type',
            LFScrollControllerEventTypeV2.scrollToBottom,
          ),
        ),
      );
      controller.scrollToBottom();
    });

    test('emits scrollToPosition event with position', () {
      expectLater(
        controller.stream,
        emits(
          isA<LFScrollControllerEventV2>()
              .having(
                (e) => e.type,
                'type',
                LFScrollControllerEventTypeV2.scrollToPosition,
              )
              .having((e) => e.position, 'position', 100.0),
        ),
      );
      controller.scrollToPosition(position: 100.0, animated: true);
    });

    test('emits loading event', () {
      expectLater(
        controller.stream,
        emits(
          isA<LFScrollControllerEventV2>().having(
            (e) => e.type,
            'type',
            LFScrollControllerEventTypeV2.loading,
          ),
        ),
      );
      controller.setLoadingState(value: true);
    });

    test('isLoading defaults to false', () {
      expect(controller.isLoading, false);
    });
  });

  group('LFScrollControllerEventV2', () {
    test('stores type and defaults', () {
      final event = LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.scrollToTop,
      );
      expect(event.type, LFScrollControllerEventTypeV2.scrollToTop);
      expect(event.animated, false);
      expect(event.position, isNull);
      expect(event.duration, isNull);
    });

    test('stores optional fields', () {
      final event = LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.scrollToPosition,
        animated: true,
        position: 250.0,
        duration: const Duration(seconds: 1),
      );
      expect(event.animated, true);
      expect(event.position, 250.0);
      expect(event.duration, const Duration(seconds: 1));
    });
  });
}
