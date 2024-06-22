part of '../scroll.dart';

class LFListViewCupertino<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final bool loading;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool shrinkWrap;
  final bool scrollable;
  final bool reverse;
  final bool hasReachedMax;

  const LFListViewCupertino({
    super.key,
    required this.builder,
    required this.storageKey,
    required this.onRefresh,
    required this.items,
    required this.loading,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.reverse = false,
    this.hasReachedMax = true,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    var totalCount = items.length + 1;
    if (header != null) totalCount += 1;

    final refreshControlWidget = CupertinoSliverRefreshControl(
      refreshTriggerPullDistance: 100.0,
      refreshIndicatorExtent: 30.0,
      onRefresh: () async {
        await onRefresh?.call();
      },
    );

    return CustomScrollView(
      key: storageKey,
      controller: PrimaryScrollController.of(context),
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: keyboardDismissBehavior,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      slivers: [
        if (onRefresh != null) ...[
          refreshControlWidget,
        ] else ...[
          const SliverToBoxAdapter(),
        ],
        SliverPadding(
          padding: padding ?? const EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
              childCount: totalCount,
            ),
          ),
        ),
      ],
    );
  }
}
