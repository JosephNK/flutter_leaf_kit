part of '../scroll.dart';

class LFGridViewMaterial<T> extends StatelessWidget {
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

  const LFGridViewMaterial({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    var totalCount = items.length;

    final gridViewWidget = GridView.builder(
      key: storageKey,
      gridDelegate: gridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1.5,
            crossAxisSpacing: 1.5,
          ),
      itemCount: totalCount,
      controller: scrollable ? PrimaryScrollController.of(context) : null,
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const ClampingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final itemIndex = index;
        final item = items[itemIndex];
        final itemWidget = builder(context, item, itemIndex);
        return itemWidget;
      },
    );

    if (onRefresh == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (header != null) ? header! : Container(),
          Flexible(
            child: gridViewWidget,
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (header != null) ? header! : Container(),
          Flexible(
            child: gridViewWidget,
          ),
        ],
      ),
    );
  }
}
