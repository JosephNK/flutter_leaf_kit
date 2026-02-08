part of '../lf_scroll_common.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewDidScroll = void Function(LFScrollInfoData scrollData);

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewRefresh = Future<void> Function();

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewLoadMore = Future<void> Function();

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewScrollToTop =
    void Function(BuildContext context, {bool animated});

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewScrollToIndex = void Function(int index);

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewLoading = void Function(bool value);

@Deprecated('V1 component deprecated. Use V2 components instead.')
typedef LFScrollViewReachedMax = void Function(bool value);
