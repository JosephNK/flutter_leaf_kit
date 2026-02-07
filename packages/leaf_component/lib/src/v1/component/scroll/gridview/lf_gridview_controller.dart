part of '../scroll.dart';

@Deprecated('Use LeafScrollController instead.')
class LFGridViewController with LFScrollControllerMixin {
  LFGridViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
