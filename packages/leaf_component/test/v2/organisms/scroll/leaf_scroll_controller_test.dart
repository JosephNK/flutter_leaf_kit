import 'package:flutter_leaf_component/src/v2/organisms/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafScrollController', () {
    late LeafScrollController controller;

    setUp(() {
      controller = LeafScrollController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('emits scrollToTop event', () {
      expectLater(
        controller.stream,
        emits(
          isA<LeafScrollControllerEvent>().having(
            (e) => e.type,
            'type',
            LeafScrollControllerEventType.scrollToTop,
          ),
        ),
      );
      controller.scrollToTop(animated: true);
    });

    test('emits scrollToBottom event', () {
      expectLater(
        controller.stream,
        emits(
          isA<LeafScrollControllerEvent>().having(
            (e) => e.type,
            'type',
            LeafScrollControllerEventType.scrollToBottom,
          ),
        ),
      );
      controller.scrollToBottom();
    });

    test('emits scrollToPosition event with position', () {
      expectLater(
        controller.stream,
        emits(
          isA<LeafScrollControllerEvent>()
              .having(
                (e) => e.type,
                'type',
                LeafScrollControllerEventType.scrollToPosition,
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
          isA<LeafScrollControllerEvent>().having(
            (e) => e.type,
            'type',
            LeafScrollControllerEventType.loading,
          ),
        ),
      );
      controller.setLoadingState(value: true);
    });

    test('isLoading defaults to false', () {
      expect(controller.isLoading, false);
    });
  });

  group('LeafScrollControllerEvent', () {
    test('stores type and defaults', () {
      final event = LeafScrollControllerEvent(
        LeafScrollControllerEventType.scrollToTop,
      );
      expect(event.type, LeafScrollControllerEventType.scrollToTop);
      expect(event.animated, false);
      expect(event.position, isNull);
      expect(event.duration, isNull);
    });

    test('stores optional fields', () {
      final event = LeafScrollControllerEvent(
        LeafScrollControllerEventType.scrollToPosition,
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
