part of leaf_scroll_component;

class LeafListViewCupertino<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key storageKey;
  final LeafScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const LeafListViewCupertino({
    Key? key,
    required this.builder,
    required this.storageKey,
    required this.onRefresh,
    required this.items,
    required this.loading,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    var totalCount = items.length + 1;
    if (header != null) totalCount += 1;

    return CustomScrollView(
      key: storageKey,
      controller: PrimaryScrollController.of(context),
      physics: AlwaysScrollableScrollPhysics(
        parent: physics ?? const BouncingScrollPhysics(),
      ),
      shrinkWrap: shrinkWrap,
      slivers: [
        CupertinoSliverRefreshControl(
          refreshTriggerPullDistance: 100.0,
          refreshIndicatorExtent: 30.0,
          onRefresh: () async {
            await onRefresh?.call();
          },
        ),
        SliverPadding(
          padding: padding ?? const EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (header != null && index == 0) {
                  return header!;
                }

                if (totalCount - 1 == index) {
                  return LeafListViewIndicator(
                    loading: loading,
                  );
                }

                final itemIndex = (header == null) ? index : index - 1;
                final item = items[itemIndex];
                final itemWidget = builder(context, item, itemIndex);
                return itemWidget;
              },
              childCount: totalCount,
            ),
          ),
        ),
      ],
    );
  }
}
