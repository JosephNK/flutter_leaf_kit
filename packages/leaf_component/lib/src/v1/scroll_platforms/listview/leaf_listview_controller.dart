part of leaf_scroll_component;

class LeafListViewController {
  LeafScrollViewScrollToTop? scrollToTop;
  LeafScrollViewLoading? setLoading;
  bool isLoading;
  bool isReachedMax;

  LeafListViewController({
    this.isLoading = false,
    this.isReachedMax = false,
  });

  void dispose() {
    scrollToTop = null;
    setLoading = null;

    isLoading = false;
    isReachedMax = false;
  }
}
