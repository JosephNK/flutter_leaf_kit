part of '../lf_scroll_common.dart';

abstract class LFScrollProvider {
  void loadMore();
  void didScroll(LFScrollInfoData scrollData);
}

mixin LFScrollControlMixin<T extends StatefulWidget> on State<T>
    implements LFScrollProvider {
  ScrollDirection scrollDirection = ScrollDirection.idle;
  bool loading = false;
  bool reachedMax = false;

  Future<void> onPullToRefresh(
    BuildContext context,
    Future<void> Function()? callback,
  ) async {
    if (mounted) {
      loading = true;
      setState(() => loading = true);
    }
    await callback?.call();
    if (mounted) {
      loading = false;
      setState(() => loading = false);
    }
  }

  Future<void> onPullToLoadMore(
    BuildContext context,
    Future<void> Function()? callback,
  ) async {
    if (mounted) {
      loading = true;
      setState(() => loading = true);
    }
    await callback?.call();
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      loading = false;
      setState(() => loading = false);
    }
  }

  void scrollToTop(
    BuildContext context, {
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    if (mounted) {
      var scrollController = PrimaryScrollController.of(context);

      if (!scrollController.hasClients) {
        return;
      }

      double value = 0.0;

      if (animated == true) {
        scrollController.animateTo(
          value,
          duration: animationDuration,
          curve: Curves.fastOutSlowIn,
        );
      } else {
        scrollController.jumpTo(value);
      }
    }
  }

  void scrollToBottom(
    BuildContext context, {
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    if (mounted) {
      var scrollController = PrimaryScrollController.of(context);

      if (!scrollController.hasClients) {
        return;
      }

      double value = scrollController.position.maxScrollExtent;

      if (animated == true) {
        scrollController.animateTo(
          value,
          duration: animationDuration,
          curve: Curves.fastOutSlowIn,
        );
      } else {
        scrollController.jumpTo(value);
      }
    }
  }

  void setLoading(bool value) {
    if (mounted) {
      loading = value;
      setState(() => loading = value);
    }
  }

  void setReachedMax(bool value) {
    if (mounted) {
      reachedMax = value;
    }
  }

  /// ScrollNotification

  void setScrollDirection(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification) {
      final direction = scrollNotification.direction;
      if (direction == ScrollDirection.forward) {
        scrollDirection = ScrollDirection.forward;
      } else if (direction == ScrollDirection.reverse) {
        scrollDirection = ScrollDirection.reverse;
      } else if (direction == ScrollDirection.idle) {
        scrollDirection = ScrollDirection.idle;
      }
    }
  }

  bool didScrollWithLoadMore(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      // final _scrollDelta = scrollNotification.scrollDelta?.abs() ?? 0.0;
      final dragDetails = scrollNotification.dragDetails;
      final isDragDetails = dragDetails != null;
      final atEdge = scrollNotification.metrics.atEdge;
      final pixels = scrollNotification.metrics.pixels;
      final maxScrollExtent = scrollNotification.metrics.maxScrollExtent;
      final triggerScrollExtent = 0.95 * maxScrollExtent;

      final isEdgeTop = atEdge ? pixels == 0.0 : false;
      final isNearTop = pixels <= 10.0;

      final data = LFScrollInfoData(
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
