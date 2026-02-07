import 'package:flutter_leaf_component/src/v2/organisms/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFScrollViewTypedefV2', () {
    test('LFScrollViewRefreshV2 can be assigned', () {
      Future<void> callback() async {}
      LFScrollViewRefreshV2 typed = callback;
      expect(typed, isNotNull);
    });

    test('LFScrollViewLoadMoreV2 can be assigned', () {
      Future<void> callback() async {}
      LFScrollViewLoadMoreV2 typed = callback;
      expect(typed, isNotNull);
    });

    test('LFScrollViewDidScrollV2 can be assigned', () {
      LFScrollViewDidScrollV2? callback;
      expect(callback, isNull);
    });

    test('LFScrollViewLoadingV2 can be assigned', () {
      void callback(_) {}
      LFScrollViewLoadingV2 typed = callback;
      expect(typed, isNotNull);
    });

    test('LFScrollViewReachedMaxV2 can be assigned', () {
      void callback(_) {}
      LFScrollViewReachedMaxV2 typed = callback;
      expect(typed, isNotNull);
    });
  });
}
