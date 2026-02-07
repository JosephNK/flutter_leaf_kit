import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_leaf_component/src/v2/organisms/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFScrollInfoDataV2', () {
    test('stores all properties', () {
      final data = LFScrollInfoDataV2(
        scrollNotification: _createFakeScrollNotification(),
        position: 50.0,
        maxScrollExtent: 1000.0,
        direction: ScrollDirection.forward,
        isEdgeTop: false,
        isAppearTop: false,
      );

      expect(data.position, 50.0);
      expect(data.maxScrollExtent, 1000.0);
      expect(data.direction, ScrollDirection.forward);
      expect(data.isEdgeTop, false);
      expect(data.isAppearTop, false);
    });

    test('equality works for identical values', () {
      final notification = _createFakeScrollNotification();

      final a = LFScrollInfoDataV2(
        scrollNotification: notification,
        position: 50.0,
        maxScrollExtent: 1000.0,
        direction: ScrollDirection.forward,
        isEdgeTop: false,
        isAppearTop: true,
      );

      final b = LFScrollInfoDataV2(
        scrollNotification: notification,
        position: 50.0,
        maxScrollExtent: 1000.0,
        direction: ScrollDirection.forward,
        isEdgeTop: false,
        isAppearTop: true,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('inequality for different values', () {
      final notification = _createFakeScrollNotification();

      final a = LFScrollInfoDataV2(
        scrollNotification: notification,
        position: 50.0,
        maxScrollExtent: 1000.0,
        direction: ScrollDirection.forward,
        isEdgeTop: false,
        isAppearTop: false,
      );

      final b = LFScrollInfoDataV2(
        scrollNotification: notification,
        position: 100.0,
        maxScrollExtent: 1000.0,
        direction: ScrollDirection.reverse,
        isEdgeTop: true,
        isAppearTop: false,
      );

      expect(a, isNot(equals(b)));
    });
  });
}

/// Creates a minimal fake [ScrollNotification] for testing.
_FakeScrollNotification _createFakeScrollNotification() {
  return _FakeScrollNotification();
}

class _FakeScrollMetrics extends FixedScrollMetrics {
  _FakeScrollMetrics()
      : super(
          minScrollExtent: 0,
          maxScrollExtent: 1000,
          pixels: 50,
          viewportDimension: 600,
          axisDirection: AxisDirection.down,
          devicePixelRatio: 1.0,
        );
}

class _FakeScrollNotification extends ScrollNotification {
  _FakeScrollNotification()
      : super(
          metrics: _FakeScrollMetrics(),
          context: null,
        );
}
