import 'package:flutter/widgets.dart';

import 'leaf_scroll_info_data.dart';

/// Callback fired when scroll position changes.
typedef LeafScrollViewDidScroll = void Function(LeafScrollInfoData scrollData);

/// Callback for pull-to-refresh.
typedef LeafScrollViewRefresh = Future<void> Function();

/// Callback for infinite-scroll load-more.
typedef LeafScrollViewLoadMore = Future<void> Function();

/// Callback to programmatically scroll to top.
typedef LeafScrollViewScrollToTop =
    void Function(BuildContext context, {bool animated});

/// Callback to programmatically scroll to a specific index.
typedef LeafScrollViewScrollToIndex = void Function(int index);

/// Callback to update the loading flag.
typedef LeafScrollViewLoading = void Function(bool value);

/// Callback to update the reached-max flag.
typedef LeafScrollViewReachedMax = void Function(bool value);
