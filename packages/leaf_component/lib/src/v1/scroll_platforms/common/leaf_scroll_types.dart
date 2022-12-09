part of leaf_scroll_component;

typedef LeafScrollViewDidScroll = void Function(LeafScrollData scrollData);

typedef LeafScrollViewRefresh = Future<void> Function();

typedef LeafScrollViewLoadMore = Future<void> Function();

typedef LeafScrollViewScrollToTop = void Function(
  BuildContext context, {
  bool animated,
});

typedef LeafScrollViewScrollToIndex = void Function(int index);

typedef LeafScrollViewLoading = void Function(bool value);

typedef LeafScrollViewReachedMax = void Function(bool value);
