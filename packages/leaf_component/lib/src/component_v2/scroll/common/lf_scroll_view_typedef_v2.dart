import 'package:flutter/widgets.dart';

import 'lf_scroll_info_data_v2.dart';

/// Callback fired when scroll position changes.
typedef LFScrollViewDidScrollV2 = void Function(
  LFScrollInfoDataV2 scrollData,
);

/// Callback for pull-to-refresh.
typedef LFScrollViewRefreshV2 = Future<void> Function();

/// Callback for infinite-scroll load-more.
typedef LFScrollViewLoadMoreV2 = Future<void> Function();

/// Callback to programmatically scroll to top.
typedef LFScrollViewScrollToTopV2 = void Function(
  BuildContext context, {
  bool animated,
});

/// Callback to programmatically scroll to a specific index.
typedef LFScrollViewScrollToIndexV2 = void Function(int index);

/// Callback to update the loading flag.
typedef LFScrollViewLoadingV2 = void Function(bool value);

/// Callback to update the reached-max flag.
typedef LFScrollViewReachedMaxV2 = void Function(bool value);
