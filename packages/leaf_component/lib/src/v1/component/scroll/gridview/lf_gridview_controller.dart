part of '../scroll.dart';

@Deprecated('Use LFScrollControllerV2 instead.')
class LFGridViewController with LFScrollControllerMixin {
  LFGridViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
