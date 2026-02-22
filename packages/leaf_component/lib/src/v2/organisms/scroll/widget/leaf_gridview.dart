import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/leaf_disallow_glow_behavior.dart';
import '../common/leaf_scroll_control_mixin.dart';
import '../common/leaf_scroll_controller_mixin.dart';
import '../common/leaf_scroll_info_data.dart';
import '../common/leaf_scroll_view_typedef.dart';
import '../controller/leaf_scroll_controller.dart';

/// A unified Material/Cupertino grid view with pull-to-refresh support.
///
/// On Apple platforms (iOS/macOS) uses [CupertinoSliverRefreshControl];
/// on other platforms uses [RefreshIndicator].
class LeafGridView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LeafScrollController? controller;
  final LeafScrollViewRefresh? onRefresh;
  final LeafScrollViewLoadMore? onLoadMore;
  final LeafScrollViewDidScroll? onDidScroll;
  final SliverGridDelegate? gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool reverse;
  final bool enableTapUnFocus;
  final bool hasReachedMax;
  final RefreshControlIndicatorBuilder? refreshIndicatorBuilder;
  final LeafRefreshStyle refreshStyle;

  const LeafGridView({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.gridDelegate,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.reverse = false,
    this.enableTapUnFocus = false,
    this.hasReachedMax = true,
    this.refreshIndicatorBuilder,
    this.refreshStyle = LeafRefreshStyle.auto,
  });

  @override
  State<LeafGridView<T>> createState() => _LeafGridViewState<T>();
}

class _LeafGridViewState<T> extends State<LeafGridView<T>>
    with LeafScrollControlMixin {
  StreamSubscription<LeafScrollControllerEvent>? _streamSubscription;

  static const _defaultGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 1.5,
    crossAxisSpacing: 1.5,
  );

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
  void didUpdateWidget(covariant LeafGridView<T> oldWidget) {
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
    final useCupertino = switch (widget.refreshStyle) {
      LeafRefreshStyle.cupertino => true,
      LeafRefreshStyle.material => false,
      LeafRefreshStyle.auto => isApple,
    };

    if (useCupertino) {
      return _buildCupertinoGridView(context);
    }

    final gridView = _buildMaterialGridView(context);
    if (widget.disallowGlow) {
      return ScrollConfiguration(
        behavior: LeafDisallowGlowBehavior(),
        child: gridView,
      );
    }
    return gridView;
  }

  Widget _buildMaterialGridView(BuildContext context) {
    final delegate = widget.gridDelegate ?? _defaultGridDelegate;

    final gridViewWidget = GridView.builder(
      key: widget.storageKey,
      gridDelegate: delegate,
      itemCount: widget.items.length,
      controller: widget.scrollable
          ? PrimaryScrollController.of(context)
          : null,
      physics: widget.scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: widget.physics ?? const ClampingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      itemBuilder: (context, index) {
        return widget.builder(context, widget.items[index], index);
      },
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) widget.header!,
        Flexible(child: gridViewWidget),
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

  Widget _buildCupertinoGridView(BuildContext context) {
    final delegate = widget.gridDelegate ?? _defaultGridDelegate;

    return CustomScrollView(
      key: widget.storageKey,
      controller: widget.scrollable
          ? PrimaryScrollController.of(context)
          : null,
      physics: widget.scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: widget.physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      slivers: [
        if (widget.onRefresh != null)
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 100.0,
            refreshIndicatorExtent: 30.0,
            builder:
                widget.refreshIndicatorBuilder ??
                CupertinoSliverRefreshControl.buildRefreshIndicator,
            onRefresh: () async {
              await onPullToRefresh(context, widget.onRefresh);
            },
          )
        else
          const SliverToBoxAdapter(),
        if (widget.header != null) SliverToBoxAdapter(child: widget.header),
        SliverPadding(
          padding: EdgeInsets.zero,
          sliver: SliverGrid(
            gridDelegate: delegate,
            delegate: SliverChildBuilderDelegate((context, index) {
              return widget.builder(context, widget.items[index], index);
            }, childCount: widget.items.length),
          ),
        ),
      ],
    );
  }
}
