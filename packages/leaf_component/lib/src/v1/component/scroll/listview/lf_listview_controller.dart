part of '../scroll.dart';

@Deprecated('Use LeafScrollController instead.')
class LFListViewController extends Object with LFScrollControllerMixin {
  LFListViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
