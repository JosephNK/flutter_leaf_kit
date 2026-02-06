import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/lf_disallow_glow_behavior_v2.dart';
import '../common/lf_scroll_control_mixin_v2.dart';
import '../common/lf_scroll_controller_mixin_v2.dart';
import '../common/lf_scroll_info_data_v2.dart';
import '../common/lf_scroll_view_typedef_v2.dart';
import '../controller/lf_scroll_controller_v2.dart';

/// A unified Material/Cupertino scroll view wrapper for a single child.
///
/// On Apple platforms uses [CustomScrollView] + [CupertinoSliverRefreshControl];
/// on other platforms uses [SingleChildScrollView] + [RefreshIndicator].
class LFScrollViewV2 extends StatefulWidget {
  final Key? storageKey;
  final Widget child;
  final LFScrollControllerV2? controller;
  final LFScrollViewRefreshV2? onRefresh;
  final LFScrollViewDidScrollV2? onDidScroll;
  final bool dragKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool reverse;

  const LFScrollViewV2({
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
  });

  @override
  State<LFScrollViewV2> createState() => _LFScrollViewV2State();
}

class _LFScrollViewV2State extends State<LFScrollViewV2>
    with LFScrollControlMixinV2 {
  StreamSubscription<LFScrollControllerEventV2>? _streamSubscription;

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
  void didScroll(LFScrollInfoDataV2 scrollData) {
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
      return _buildCupertinoScrollView(context);
    }

    final scrollView = _buildMaterialScrollView(context);
    if (widget.disallowGlow) {
      return ScrollConfiguration(
        behavior: LFDisallowGlowBehaviorV2(),
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
