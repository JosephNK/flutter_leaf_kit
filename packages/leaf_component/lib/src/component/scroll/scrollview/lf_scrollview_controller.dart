part of '../scroll.dart';

@Deprecated('Use LFScrollControllerV2 instead.')
class LFScrollViewController with LFScrollControllerMixin {
  LFScrollViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
