part of leaf_scroll_component;

class LeafScrollViewController {
  LeafScrollViewScrollToTop? scrollToTop;
  LeafScrollViewScrollToIndex? scrollToIndex; // TODO
  LeafScrollViewLoading? setLoading;
  bool isLoading;

  LeafScrollViewController({
    this.isLoading = false,
  });

  void dispose() {
    scrollToTop = null;
    scrollToIndex = null;
    setLoading = null;

    isLoading = false;
  }
}
