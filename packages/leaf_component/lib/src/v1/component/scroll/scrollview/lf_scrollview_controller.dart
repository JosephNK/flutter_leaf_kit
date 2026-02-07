part of '../scroll.dart';

@Deprecated('Use LeafScrollController instead.')
class LFScrollViewController with LFScrollControllerMixin {
  LFScrollViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
