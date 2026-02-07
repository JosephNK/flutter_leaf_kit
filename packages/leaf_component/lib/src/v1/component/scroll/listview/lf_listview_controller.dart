part of '../scroll.dart';

@Deprecated('Use LFScrollControllerV2 instead.')
class LFListViewController extends Object with LFScrollControllerMixin {
  LFListViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
