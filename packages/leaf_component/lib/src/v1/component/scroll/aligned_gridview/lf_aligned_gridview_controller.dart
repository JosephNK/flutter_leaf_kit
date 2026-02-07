part of '../scroll.dart';

@Deprecated('Use LeafScrollController instead.')
class LFAlignedGridViewController with LFScrollControllerMixin {
  LFAlignedGridViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
