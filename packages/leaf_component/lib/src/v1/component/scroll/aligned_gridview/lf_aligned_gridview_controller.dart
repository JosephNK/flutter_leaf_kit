part of '../scroll.dart';

@Deprecated('Use LFScrollControllerV2 instead.')
class LFAlignedGridViewController with LFScrollControllerMixin {
  LFAlignedGridViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
