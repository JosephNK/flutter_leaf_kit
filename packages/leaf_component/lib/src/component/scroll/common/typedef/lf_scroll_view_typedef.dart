part of '../lf_scroll_common.dart';

typedef LFScrollViewDidScroll = void Function(
  LFScrollInfoData scrollData,
);

typedef LFScrollViewRefresh = Future<void> Function();

typedef LFScrollViewLoadMore = Future<void> Function();

typedef LFScrollViewScrollToTop = void Function(
  BuildContext context, {
  bool animated,
});

typedef LFScrollViewScrollToIndex = void Function(
  int index,
);

typedef LFScrollViewLoading = void Function(
  bool value,
);

typedef LFScrollViewReachedMax = void Function(
  bool value,
);
