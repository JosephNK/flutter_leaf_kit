import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component_v2/indicator/widget/lf_indicator_v2.dart';
import '../common/lf_disallow_glow_behavior_v2.dart';
import '../common/lf_scroll_control_mixin_v2.dart';
import '../common/lf_scroll_controller_mixin_v2.dart';
import '../common/lf_scroll_info_data_v2.dart';
import '../common/lf_scroll_view_typedef_v2.dart';
import '../controller/lf_scroll_controller_v2.dart';

/// A unified Material/Cupertino list view with pull-to-refresh and
/// infinite-scroll load-more support.
///
/// On Apple platforms (iOS/macOS) uses [CupertinoSliverRefreshControl];
/// on other platforms uses [RefreshIndicator].
class LFListViewV2<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LFScrollControllerV2? controller;
  final LFScrollViewRefreshV2? onRefresh;
  final LFScrollViewLoadMoreV2? onLoadMore;
  final LFScrollViewDidScrollV2? onDidScroll;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool reverse;
  final bool enableTapUnFocus;
  final bool hasReachedMax;

  const LFListViewV2({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.reverse = false,
    this.enableTapUnFocus = false,
    this.hasReachedMax = true,
  });

  @override
  State<LFListViewV2<T>> createState() => _LFListViewV2State<T>();
}

class _LFListViewV2State<T> extends State<LFListViewV2<T>>
    with LFScrollControlMixinV2 {
  StreamSubscription<LFScrollControllerEventV2>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    initControlMixin(widget.physics);
    _listenToController();
    setReachedMax(widget.hasReachedMax);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFListViewV2<T> oldWidget) {
    if (oldWidget.hasReachedMax != widget.hasReachedMax) {
      setReachedMax(widget.hasReachedMax);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didScroll(LFScrollInfoDataV2 scrollData) {
    widget.onDidScroll?.call(scrollData);
  }

  @override
  void loadMore() async {
    await onPullToLoadMore(context, widget.onLoadMore);
  }

  @override
  void setLoading(bool value) {
    super.setLoading(value);
    widget.controller?.isLoading = value;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        final scrollController = PrimaryScrollController.of(context);
        if (scrollNotification.depth > 0 || !scrollController.hasClients) {
          return false;
        }
        setScrollDirection(scrollNotification);
        return didScrollWithLoadMore(scrollNotification);
      },
      child: GestureDetector(
        behavior: widget.enableTapUnFocus ? HitTestBehavior.opaque : null,
        onTap: widget.enableTapUnFocus
            ? () => FocusScope.of(context).unfocus()
            : null,
        child: _buildPlatformView(context),
      ),
    );
  }

  // -- Private --

  void _listenToController() {
    _streamSubscription =
        widget.controller?.stream.listen((event) async {
      final mContext = context;
      final duration =
          event.duration ?? const Duration(milliseconds: 300);
      switch (event.type) {
        case LFScrollControllerEventTypeV2.scrollToPosition:
          setClampingPhysics();
          if (mContext.mounted) {
            await scrollToPosition(
              mContext,
              animated: event.animated,
              value: event.position,
              animationDuration: duration,
            );
          }
          resetPhysics();
        case LFScrollControllerEventTypeV2.scrollToTop:
          if (mContext.mounted) {
            await scrollToTop(
              mContext,
              animated: event.animated,
              animationDuration: duration,
            );
          }
        case LFScrollControllerEventTypeV2.scrollToBottom:
          if (mContext.mounted) {
            await scrollToBottom(
              mContext,
              animated: event.animated,
              animationDuration: duration,
            );
          }
        case LFScrollControllerEventTypeV2.loading:
          setLoading(event.animated);
      }
    });
  }

  Widget _buildPlatformView(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isApple) {
      return _buildCupertinoListView(context);
    }

    final listView = _buildMaterialListView(context);
    if (widget.disallowGlow) {
      return ScrollConfiguration(
        behavior: LFDisallowGlowBehaviorV2(),
        child: listView,
      );
    }
    return listView;
  }

  Widget _buildMaterialListView(BuildContext context) {
    var totalCount = widget.items.length + 1;
    if (widget.header != null) totalCount += 1;

    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: widget.physics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    final listView = ListView.builder(
      key: widget.storageKey,
      itemCount: totalCount,
      controller: PrimaryScrollController.of(context),
      physics: scrollPhysics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      itemBuilder: (context, index) {
        if (widget.header != null && index == 0) {
          return widget.header!;
        }

        final isLast = (totalCount - 1 == index);
        if (isLast) {
          if (!widget.hasReachedMax) {
            return _LFScrollLoadingIndicatorV2(loading: loading);
          }
          return const SizedBox.shrink();
        }

        final itemIndex = (widget.header == null) ? index : index - 1;
        return widget.builder(context, widget.items[itemIndex], itemIndex);
      },
    );

    if (widget.onRefresh == null) return listView;

    return RefreshIndicator(
      onRefresh: () async {
        await onPullToRefresh(context, widget.onRefresh);
      },
      child: listView,
    );
  }

  Widget _buildCupertinoListView(BuildContext context) {
    var totalCount = widget.items.length + 1;
    if (widget.header != null) totalCount += 1;

    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: widget.physics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    return CustomScrollView(
      key: widget.storageKey,
      controller: PrimaryScrollController.of(context),
      physics: scrollPhysics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      slivers: [
        if (widget.onRefresh != null)
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 100.0,
            refreshIndicatorExtent: 30.0,
            onRefresh: () async {
              await onPullToRefresh(context, widget.onRefresh);
            },
          )
        else
          const SliverToBoxAdapter(),
        SliverPadding(
          padding: widget.padding ?? EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (widget.header != null && index == 0) {
                  return widget.header!;
                }

                final isLast = (totalCount - 1 == index);
                if (isLast) {
                  if (!widget.hasReachedMax) {
                    return _LFScrollLoadingIndicatorV2(loading: loading);
                  }
                  return const SizedBox.shrink();
                }

                final itemIndex =
                    (widget.header == null) ? index : index - 1;
                return widget.builder(
                    context, widget.items[itemIndex], itemIndex);
              },
              childCount: totalCount,
            ),
          ),
        ),
      ],
    );
  }
}

/// Shared loading indicator for scroll views (load-more / pagination).
class _LFScrollLoadingIndicatorV2 extends StatelessWidget {
  final bool loading;

  const _LFScrollLoadingIndicatorV2({required this.loading});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const Center(
          child: LFIndicatorV2(size: LFIndicatorSizeV2.medium),
        ),
      ),
    );
  }
}
