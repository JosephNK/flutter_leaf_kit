part of '../lf_scroll.dart';

class LFScrollViewController with LFScrollControllerMixin {
  LFScrollViewController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
