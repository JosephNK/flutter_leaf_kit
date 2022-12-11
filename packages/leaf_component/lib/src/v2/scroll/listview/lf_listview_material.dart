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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    var totalCount = items.length + 1;
    if (header != null) totalCount += 1;

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: ListView.builder(
        key: storageKey,
        itemCount: totalCount,
        controller: PrimaryScrollController.of(context),
        physics: AlwaysScrollableScrollPhysics(
          parent: physics ?? const ClampingScrollPhysics(),
        ),
        padding: padding,
        shrinkWrap: shrinkWrap,
        itemBuilder: (context, index) {
          if (header != null && index == 0) {
            return header!;
          }

          if (totalCount - 1 == index) {
            return LFListViewIndicator(
              loading: loading,
            );
          }

          final itemIndex = (header == null) ? index : index - 1;
          final item = items[itemIndex];
          final itemWidget = builder(context, item, itemIndex);
          return itemWidget;
        },
      ),
    );
  }
}
