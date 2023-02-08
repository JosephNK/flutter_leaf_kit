part of lf_scroll_component;

class LFListViewController with LFScrollControllerMixin {
  ScrollController? scrollController;

  LFListViewController() {
    init();
  }

  void dispose() {
    scrollController?.dispose();
    tearDown();
  }
}
