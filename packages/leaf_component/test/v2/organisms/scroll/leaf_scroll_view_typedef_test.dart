import 'package:flutter_leaf_component/src/v2/organisms/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafScrollViewTypedef', () {
    test('LeafScrollViewRefresh can be assigned', () {
      Future<void> callback() async {}
      LeafScrollViewRefresh typed = callback;
      expect(typed, isNotNull);
    });

    test('LeafScrollViewLoadMore can be assigned', () {
      Future<void> callback() async {}
      LeafScrollViewLoadMore typed = callback;
      expect(typed, isNotNull);
    });

    test('LeafScrollViewDidScroll can be assigned', () {
      LeafScrollViewDidScroll? callback;
      expect(callback, isNull);
    });

    test('LeafScrollViewLoading can be assigned', () {
      void callback(_) {}
      LeafScrollViewLoading typed = callback;
      expect(typed, isNotNull);
    });

    test('LeafScrollViewReachedMax can be assigned', () {
      void callback(_) {}
      LeafScrollViewReachedMax typed = callback;
      expect(typed, isNotNull);
    });
  });
}
