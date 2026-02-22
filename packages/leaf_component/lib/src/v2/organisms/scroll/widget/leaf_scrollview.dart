import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/leaf_disallow_glow_behavior.dart';
import '../common/leaf_scroll_control_mixin.dart';
import '../common/leaf_scroll_controller_mixin.dart';
import '../common/leaf_scroll_info_data.dart';
import '../common/leaf_scroll_view_typedef.dart';
import '../controller/leaf_scroll_controller.dart';

/// A unified Material/Cupertino scroll view wrapper for a single child.
///
/// On Apple platforms uses [CustomScrollView] + [CupertinoSliverRefreshControl];
/// on other platforms uses [SingleChildScrollView] + [RefreshIndicator].
class LeafScrollView extends StatefulWidget {
  final Key? storageKey;
  final Widget child;
  final LeafScrollController? controller;
  final LeafScrollViewRefresh? onRefresh;
  final LeafScrollViewDidScroll? onDidScroll;
  final bool dragKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool reverse;
  final RefreshControlIndicatorBuilder? refreshIndicatorBuilder;
  final LeafRefreshStyle refreshStyle;

  const LeafScrollView({
    super.key,
    this.storageKey,
    required this.child,
    this.controller,
    this.onRefresh,
    this.onDidScroll,
    this.dragKeyboardHide = false,
    this.physics,
    this.padding,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.enableTapUnFocus = false,
    this.reverse = false,
    this.refreshIndicatorBuilder,
    this.refreshStyle = LeafRefreshStyle.auto,
  });

  @override
  State<LeafScrollView> createState() => _LeafScrollViewState();
}

class _LeafScrollViewState extends State<LeafScrollView>
    with LeafScrollControlMixin {
  StreamSubscription<LeafScrollControllerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    initControlMixin(widget.physics);
    _listenToController();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didScroll(LeafScrollInfoData scrollData) {
    widget.onDidScroll?.call(scrollData);
  }

  @override
  void loadMore() {}

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
      return _buildCupertinoScrollView(context);
    }

    final scrollView = _buildMaterialScrollView(context);
    if (widget.disallowGlow) {
      return ScrollConfiguration(
        behavior: LeafDisallowGlowBehavior(),
        child: scrollView,
      );
    }
    return scrollView;
  }

  Widget _buildMaterialScrollView(BuildContext context) {
    final keyboardBehavior = widget.dragKeyboardHide
        ? ScrollViewKeyboardDismissBehavior.onDrag
        : ScrollViewKeyboardDismissBehavior.manual;

    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: currentPhysics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    final scrollView = SingleChildScrollView(
      key: widget.storageKey,
      keyboardDismissBehavior: keyboardBehavior,
      physics: scrollPhysics,
      padding: widget.padding,
      reverse: widget.reverse,
      child: widget.child,
    );

    if (widget.onRefresh == null) return scrollView;

    return RefreshIndicator(
      onRefresh: () async {
        await onPullToRefresh(context, widget.onRefresh);
      },
      child: scrollView,
    );
  }

  Widget _buildCupertinoScrollView(BuildContext context) {
    final keyboardBehavior = widget.dragKeyboardHide
        ? ScrollViewKeyboardDismissBehavior.onDrag
        : ScrollViewKeyboardDismissBehavior.manual;

    final scrollPhysics = widget.scrollable
        ? AlwaysScrollableScrollPhysics(
            parent: currentPhysics ?? const BouncingScrollPhysics(),
          )
        : const NeverScrollableScrollPhysics();

    return CustomScrollView(
      key: widget.storageKey,
      keyboardDismissBehavior: keyboardBehavior,
      controller: PrimaryScrollController.of(context),
      physics: scrollPhysics,
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
        SliverPadding(
          padding: widget.padding ?? EdgeInsets.zero,
          sliver: SliverToBoxAdapter(child: widget.child),
        ),
      ],
    );
  }
}
