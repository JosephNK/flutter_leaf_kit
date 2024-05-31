part of '../scroll.dart';

class LFStaggeredGridViewMaterial<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LFStaggeredGridViewMaterial({
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
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.hasReachedMax = true,
  });

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    var totalCount = items.length;

    final gridViewWidget = AlignedGridView.count(
      key: storageKey,
      crossAxisCount: gridDelegate.crossAxisCount,
      mainAxisSpacing: gridDelegate.mainAxisSpacing,
      crossAxisSpacing: gridDelegate.crossAxisSpacing,
      itemCount: totalCount,
      controller: scrollable ? PrimaryScrollController.of(context) : null,
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final itemIndex = index;
        final item = items[itemIndex];
        final itemWidget = builder(context, item, itemIndex);
        return itemWidget;
      },
    );

    final gridWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (header != null) ? header! : Container(),
        Flexible(
          child: gridViewWidget,
        ),
        if (!hasReachedMax) ...[
          LFStaggeredGridViewIndicator(
            loading: loading,
          ),
        ]
      ],
    );

    if (onRefresh == null) {
      return gridWidget;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: gridWidget,
    );
  }
}
