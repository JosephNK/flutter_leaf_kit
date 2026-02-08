import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../atoms/indicator/widget/leaf_indicator.dart';
import '../common/leaf_disallow_glow_behavior.dart';
import '../common/leaf_scroll_control_mixin.dart';
import '../common/leaf_scroll_controller_mixin.dart';
import '../common/leaf_scroll_info_data.dart';
import '../common/leaf_scroll_view_typedef.dart';
import '../controller/leaf_scroll_controller.dart';

/// A unified Material/Cupertino list view with pull-to-refresh and
/// infinite-scroll load-more support.
///
/// On Apple platforms (iOS/macOS) uses [CupertinoSliverRefreshControl];
/// on other platforms uses [RefreshIndicator].
class LeafListView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LeafScrollController? controller;
  final LeafScrollViewRefresh? onRefresh;
  final LeafScrollViewLoadMore? onLoadMore;
  final LeafScrollViewDidScroll? onDidScroll;
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

  const LeafListView({
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
  State<LeafListView<T>> createState() => _LeafListViewState<T>();
}

class _LeafListViewState<T> extends State<LeafListView<T>>
    with LeafScrollControlMixin {
  StreamSubscription<LeafScrollControllerEvent>? _streamSubscription;

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
  void didUpdateWidget(covariant LeafListView<T> oldWidget) {
    if (oldWidget.hasReachedMax != widget.hasReachedMax) {
      setReachedMax(widget.hasReachedMax);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didScroll(LeafScrollInfoData scrollData) {
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
    _streamSubscription = widget.controller?.stream.listen((event) async {
      final mContext = context;
      final duration = event.duration ?? const Duration(milliseconds: 300);
      switch (event.type) {
        case LeafScrollControllerEventType.scrollToPosition:
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
        case LeafScrollControllerEventType.scrollToTop:
          if (mContext.mounted) {
            await scrollToTop(
              mContext,
              animated: event.animated,
              animationDuration: duration,
            );
          }
        case LeafScrollControllerEventType.scrollToBottom:
          if (mContext.mounted) {
            await scrollToBottom(
              mContext,
              animated: event.animated,
              animationDuration: duration,
            );
          }
        case LeafScrollControllerEventType.loading:
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
        behavior: LeafDisallowGlowBehavior(),
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
            return _LeafScrollLoadingIndicator(loading: loading);
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
            delegate: SliverChildBuilderDelegate((context, index) {
              if (widget.header != null && index == 0) {
                return widget.header!;
              }

              final isLast = (totalCount - 1 == index);
              if (isLast) {
                if (!widget.hasReachedMax) {
                  return _LeafScrollLoadingIndicator(loading: loading);
                }
                return const SizedBox.shrink();
              }

              final itemIndex = (widget.header == null) ? index : index - 1;
              return widget.builder(
                context,
                widget.items[itemIndex],
                itemIndex,
              );
            }, childCount: totalCount),
          ),
        ),
      ],
    );
  }
}

/// Shared loading indicator for scroll views (load-more / pagination).
class _LeafScrollLoadingIndicator extends StatelessWidget {
  final bool loading;

  const _LeafScrollLoadingIndicator({required this.loading});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const Center(
          child: LeafIndicator(size: LeafIndicatorSize.medium),
        ),
      ),
    );
  }
}
