part of lf_scroll_component;

class LFListViewMaterial<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LFListViewMaterial({
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
    this.scrollable = true,
    this.hasReachedMax = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    var totalCount = items.length + 1;
    if (header != null) totalCount += 1;

    final listView = ListView.builder(
      key: storageKey,
      itemCount: totalCount,
      controller: PrimaryScrollController.of(context),
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        if (header != null && index == 0) {
          return header!;
        }

        final isLast = (totalCount - 1 == index);
        if (isLast) {
          if (!hasReachedMax) {
            return LFListViewIndicator(
              loading: loading,
            );
          }
          return Container();
        }

        final itemIndex = (header == null) ? index : index - 1;
        final item = items[itemIndex];
        final itemWidget = builder(context, item, itemIndex);
        return itemWidget;
      },
    );

    if (onRefresh == null) {
      return listView;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: listView,
    );
  }
}
