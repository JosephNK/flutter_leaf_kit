part of leaf_scroll_component;

class LeafGridViewController {
  LeafScrollViewScrollToTop? scrollToTop;
  LeafScrollViewLoading? setLoading;
  bool isLoading;

  LeafGridViewController({
    this.isLoading = false,
  });

  void dispose() {
    scrollToTop = null;
    setLoading = null;

    isLoading = false;
  }
}
