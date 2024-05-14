part of '../scroll.dart';

class LFScrollViewCupertino<T> extends StatelessWidget {
  final Widget child;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final bool autoKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;

  const LFScrollViewCupertino({
    super.key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.autoKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoListView(context);
  }

  Widget _buildCupertinoListView(BuildContext context) {
    return CustomScrollView(
      key: storageKey,
      keyboardDismissBehavior: autoKeyboardHide
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      controller: PrimaryScrollController.of(context),
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
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
