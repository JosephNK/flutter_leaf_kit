import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../component_v2/indicator/widget/lf_indicator_v2.dart';
import '../common/lf_disallow_glow_behavior_v2.dart';
import '../common/lf_scroll_control_mixin_v2.dart';
import '../common/lf_scroll_controller_mixin_v2.dart';
import '../common/lf_scroll_info_data_v2.dart';
import '../common/lf_scroll_view_typedef_v2.dart';
import '../controller/lf_scroll_controller_v2.dart';

/// A unified Material/Cupertino aligned grid view using
/// [flutter_staggered_grid_view] with pull-to-refresh and load-more support.
class LFAlignedGridViewV2<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LFScrollControllerV2? controller;
  final LFScrollViewRefreshV2? onRefresh;
  final LFScrollViewLoadMoreV2? onLoadMore;
  final LFScrollViewDidScrollV2? onDidScroll;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool hasReachedMax;

  const LFAlignedGridViewV2({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    required this.gridDelegate,
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
    this.enableTapUnFocus = false,
    this.hasReachedMax = true,
  });

  @override
  State<LFAlignedGridViewV2<T>> createState() =>
      _LFAlignedGridViewV2State<T>();
}

class _LFAlignedGridViewV2State<T> extends State<LFAlignedGridViewV2<T>>
    with LFScrollControlMixinV2 {
  StreamSubscription<LFScrollControllerEventV2>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _listenToController();
    setReachedMax(widget.hasReachedMax);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFAlignedGridViewV2<T> oldWidget) {
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
      return _buildCupertinoAlignedGridView(context);
    }

    final gridView = _buildMaterialAlignedGridView(context);
    if (widget.disallowGlow) {
      return ScrollConfiguration(
        behavior: LFDisallowGlowBehaviorV2(),
        child: gridView,
      );
    }
    return gridView;
  }

  Widget _buildMaterialAlignedGridView(BuildContext context) {
    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: widget.physics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    final gridViewWidget = AlignedGridView.count(
      key: widget.storageKey,
      crossAxisCount: widget.gridDelegate.crossAxisCount,
      mainAxisSpacing: widget.gridDelegate.mainAxisSpacing,
      crossAxisSpacing: widget.gridDelegate.crossAxisSpacing,
      itemCount: widget.items.length,
      controller:
          widget.scrollable ? PrimaryScrollController.of(context) : null,
      physics: scrollPhysics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        return widget.builder(context, widget.items[index], index);
      },
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) widget.header!,
        Flexible(child: gridViewWidget),
        if (!widget.hasReachedMax)
          _LFAlignedGridLoadingIndicatorV2(loading: loading),
      ],
    );

    if (widget.onRefresh == null) return content;

    return RefreshIndicator(
      onRefresh: () async {
        await onPullToRefresh(context, widget.onRefresh);
      },
      child: content,
    );
  }

  Widget _buildCupertinoAlignedGridView(BuildContext context) {
    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: widget.physics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    return Container(
      padding: widget.padding,
      child: CustomScrollView(
        key: widget.storageKey,
        controller:
            widget.scrollable ? PrimaryScrollController.of(context) : null,
        physics: scrollPhysics,
        shrinkWrap: widget.shrinkWrap,
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
          if (widget.header != null)
            SliverToBoxAdapter(child: widget.header),
          SliverAlignedGrid.count(
            crossAxisCount: widget.gridDelegate.crossAxisCount,
            mainAxisSpacing: widget.gridDelegate.mainAxisSpacing,
            crossAxisSpacing: widget.gridDelegate.crossAxisSpacing,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return widget.builder(context, widget.items[index], index);
            },
          ),
          if (!widget.hasReachedMax)
            SliverToBoxAdapter(
              child: _LFAlignedGridLoadingIndicatorV2(loading: loading),
            ),
        ],
      ),
    );
  }
}

class _LFAlignedGridLoadingIndicatorV2 extends StatelessWidget {
  final bool loading;

  const _LFAlignedGridLoadingIndicatorV2({required this.loading});

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
