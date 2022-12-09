part of leaf_scroll_component;

class LeafScrollViewCupertino<T> extends StatelessWidget {
  final Widget child;
  final Key storageKey;
  final LeafScrollViewRefresh? onRefresh;
  final bool autoKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const LeafScrollViewCupertino({
    Key? key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.autoKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    return CustomScrollView(
      key: storageKey,
      controller: PrimaryScrollController.of(context),
      physics: AlwaysScrollableScrollPhysics(
        parent: physics ?? const BouncingScrollPhysics(),
      ),
      shrinkWrap: shrinkWrap,
      slivers: [
        onRefresh == null
            ? const SliverToBoxAdapter()
            : CupertinoSliverRefreshControl(
                refreshTriggerPullDistance: 100.0,
                refreshIndicatorExtent: 30.0,
                onRefresh: () async {
                  await onRefresh?.call();
                },
              ),
        SliverPadding(
          padding: padding ?? const EdgeInsets.all(0),
          sliver: SliverToBoxAdapter(
            child: child,
          ),
        ),
      ],
    );
  }
}
