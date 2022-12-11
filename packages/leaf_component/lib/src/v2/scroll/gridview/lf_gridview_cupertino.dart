part of lf_scroll_component;

class LFGridViewCupertino<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final SliverGridDelegate? gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;

  const LFGridViewCupertino({
    Key? key,
    required this.builder,
    required this.storageKey,
    required this.onRefresh,
    required this.items,
    required this.loading,
    this.gridDelegate,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.scrollable = true,
  }) : super(key: key);

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

    final gridViewWidget = SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverGrid(
        gridDelegate: gridDelegate ??
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
            ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final itemIndex = index;
            final item = items[itemIndex];
            final itemWidget = builder(context, item, itemIndex);
            return itemWidget;
          },
          childCount: totalCount,
        ),
      ),
    );

    return CustomScrollView(
      key: storageKey,
      controller: scrollable ? PrimaryScrollController.of(context) : null,
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      slivers: [
        (onRefresh != null) ? refreshControlWidget : const SliverToBoxAdapter(),
        headerWidget,
        gridViewWidget,
      ],
    );
  }
}
