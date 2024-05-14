part of '../scroll.dart';

class LFScrollViewController with LFScrollControllerMixin {
  LFScrollViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
