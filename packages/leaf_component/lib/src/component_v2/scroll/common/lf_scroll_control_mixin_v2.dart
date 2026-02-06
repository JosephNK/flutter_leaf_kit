import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'lf_scroll_info_data_v2.dart';

/// Interface for scroll-aware widget states.
abstract class LFScrollProviderV2 {
  void loadMore();
  void didScroll(LFScrollInfoDataV2 scrollData);
}

/// Mixin that provides shared scroll control logic for stateful widgets.
///
/// Handles scroll-to-top/bottom/position, pull-to-refresh, infinite scroll
/// load-more, and scroll direction tracking.
mixin LFScrollControlMixinV2<T extends StatefulWidget> on State<T>
    implements LFScrollProviderV2 {
  ScrollDirection scrollDirection = ScrollDirection.idle;
  bool loading = false;
  bool reachedMax = false;

  ScrollPhysics? currentPhysics;
  ScrollPhysics? _backupPhysics;

  void initControlMixin(ScrollPhysics? physics) {
    currentPhysics = physics;
    _backupPhysics = physics;
  }

  Future<void> onPullToRefresh(
    BuildContext context,
    Future<void> Function()? callback,
  ) async {
    if (mounted) {
      setState(() => loading = true);
    }
    await callback?.call();
    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> onPullToLoadMore(
    BuildContext context,
    Future<void> Function()? callback,
  ) async {
    if (mounted) {
      setState(() => loading = true);
    }
    await callback?.call();
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> scrollToPosition(
    BuildContext context, {
    bool animated = false,
    double? value,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    if (!mounted) return;

    final scrollController = PrimaryScrollController.of(context);
    if (!scrollController.hasClients) return;
    if (value == null) return;

    if (animated) {
      await scrollController.animateTo(
        value,
        duration: animationDuration,
        curve: curve,
      );
    } else {
      scrollController.jumpTo(value);
    }
  }

  Future<void> scrollToTop(
    BuildContext context, {
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) async {
    await scrollToPosition(
      context,
      animated: animated,
      value: 0.0,
      animationDuration: animationDuration,
    );
  }

  Future<void> scrollToBottom(
    BuildContext context, {
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) async {
    if (!mounted) return;

    final scrollController = PrimaryScrollController.of(context);
    if (!scrollController.hasClients) return;

    await scrollToPosition(
      context,
      animated: animated,
      value: scrollController.position.maxScrollExtent,
      animationDuration: animationDuration,
    );
  }

  void setLoading(bool value) {
    if (mounted) {
      setState(() => loading = value);
    }
  }

  void setReachedMax(bool value) {
    if (mounted) {
      reachedMax = value;
    }
  }

  void setClampingPhysics() {
    setState(() => currentPhysics = const ClampingScrollPhysics());
  }

  void resetPhysics() {
    setState(() => currentPhysics = _backupPhysics);
  }

  // -- ScrollNotification helpers --

  void setScrollDirection(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification) {
      scrollDirection = scrollNotification.direction;
    }
  }

  bool didScrollWithLoadMore(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      final dragDetails = scrollNotification.dragDetails;
      final isDragDetails = dragDetails != null;
      final atEdge = scrollNotification.metrics.atEdge;
      final pixels = scrollNotification.metrics.pixels;
      final maxScrollExtent = scrollNotification.metrics.maxScrollExtent;
      final triggerScrollExtent = 0.95 * maxScrollExtent;

      final isEdgeTop = atEdge ? pixels == 0.0 : false;
      final isNearTop = pixels <= 10.0;

      final data = LFScrollInfoDataV2(
        scrollNotification: scrollNotification,
        position: pixels,
        maxScrollExtent: maxScrollExtent,
        direction: scrollDirection,
        isEdgeTop: isEdgeTop,
        isAppearTop: isNearTop,
      );

      didScroll(data);

      if (pixels > triggerScrollExtent && !isDragDetails && !reachedMax) {
        if (loading) return false;
        loadMore();
      }

      return true;
    }

    return false;
  }
}
