part of '../scroll.dart';

class LFStaggeredGridViewCupertino<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LFStaggeredGridViewCupertino({
    super.key,
    required this.builder,
    required this.storageKey,
    required this.onRefresh,
    required this.items,
    required this.loading,
    required this.gridDelegate,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.hasReachedMax = true,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    var totalCount = items.length;

    final refreshControlWidget = CupertinoSliverRefreshControl(
      refreshTriggerPullDistance: 100.0,
      refreshIndicatorExtent: 30.0,
      onRefresh: () async {
        await onRefresh?.call();
      },
    );

    final headerWidget = SliverToBoxAdapter(
      child: header,
    );

    final gridViewWidget = SliverAlignedGrid.count(
      crossAxisCount: gridDelegate.crossAxisCount,
      mainAxisSpacing: gridDelegate.mainAxisSpacing,
      crossAxisSpacing: gridDelegate.crossAxisSpacing,
      itemCount: totalCount,
      itemBuilder: (context, index) {
        final itemIndex = index;
        final item = items[itemIndex];
        final itemWidget = builder(context, item, itemIndex);
        return itemWidget;
      },
    );

    return Container(
      padding: padding,
      child: CustomScrollView(
        key: storageKey,
        controller: scrollable ? PrimaryScrollController.of(context) : null,
        physics: scrollable
            ? AlwaysScrollableScrollPhysics(
                parent: physics ?? const BouncingScrollPhysics(),
              )
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        slivers: [
          if (onRefresh != null) ...[
            refreshControlWidget,
          ] else ...[
            const SliverToBoxAdapter(),
          ],
          headerWidget,
          gridViewWidget,
          if (!hasReachedMax) ...[
            SliverToBoxAdapter(
              child: LFStaggeredGridViewIndicator(
                loading: loading,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
