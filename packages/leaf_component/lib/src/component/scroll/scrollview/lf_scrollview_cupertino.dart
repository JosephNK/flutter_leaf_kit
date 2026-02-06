part of '../scroll.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFScrollViewCupertino<T> extends StatelessWidget {
  final Widget child;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final bool dragKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;
  final bool reverse;

  const LFScrollViewCupertino({
    super.key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.dragKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    return CustomScrollView(
      key: storageKey,
      keyboardDismissBehavior: dragKeyboardHide
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      controller: PrimaryScrollController.of(context),
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      reverse: reverse,
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
